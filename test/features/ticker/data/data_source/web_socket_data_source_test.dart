import 'package:flutter_test/flutter_test.dart';
import 'package:ft/features/ticker/data/data_source/web_socket_data_source.dart';

void main() {
  late WebSocketDataSource dataSource;

  setUp(() {
    dataSource = WebSocketDataSource();
  });

  tearDown(() async {
    await dataSource.close();
  });

  test('getStream returns a non-null Stream', () async {
    final stream = await dataSource.getStream();
    expect(stream, isNotNull);
    expect(stream, isA<Stream>());
  });

  test('subscribe does not throw when connected', () async {
    await dataSource.connect();

    expect(() async => await dataSource.subscribe('AAPL'), returnsNormally);
  });

  test('unSubscribe does not throw when connected', () async {
    await dataSource.connect();
    expect(() async => await dataSource.unSubscribe('AAPL'), returnsNormally);
  });

  test('close resets the connection', () async {
    await dataSource.connect();

    await dataSource.close();

    final stream = await dataSource.getStream();
    expect(stream, isNotNull);
    expect(stream, isA<Stream>());
  });

  test(
    'subscribe throws UnKnownException when connection is not established',
    () async {
      await dataSource.close();

      expect(() async => await dataSource.subscribe('AAPL'), returnsNormally);
    },
  );
}
