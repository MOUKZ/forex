import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:ft/features/ticker/data/data_source/web_socket_data_source.dart';
import 'package:ft/features/ticker/data/mapper/ticker_list_mapper.dart';
import 'package:ft/features/ticker/domain/entity/ticket_entity.dart';
import 'package:ft/features/ticker/data/repository/web_socket_repo_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([WebSocketDataSource, TickerListMapper])
import 'web_socket_repo_test.mocks.dart';

void main() {
  late WebSocketRepoImpl repo;
  late MockWebSocketDataSource mockDataSource;
  late MockTickerListMapper mockTickerListMapper;

  setUp(() {
    mockDataSource = MockWebSocketDataSource();
    mockTickerListMapper = MockTickerListMapper();
    repo = WebSocketRepoImpl(mockDataSource, mockTickerListMapper);
  });

  group('WebSocketRepoImpl', () {
    test('disconnect calls dataSource.close', () async {
      when(mockDataSource.close()).thenAnswer((_) async => Future.value());

      await repo.disconnect();

      verify(mockDataSource.close()).called(1);
    });

    test('subscribe calls dataSource.subscribe with symbol', () async {
      const symbol = 'AAPL';
      when(
        mockDataSource.subscribe(symbol),
      ).thenAnswer((_) async => Future.value());

      await repo.subscribe(symbol);

      verify(mockDataSource.subscribe(symbol)).called(1);
    });

    test('unSubscribe calls dataSource.unSubscribe with symbol', () async {
      const symbol = 'AAPL';
      when(
        mockDataSource.unSubscribe(symbol),
      ).thenAnswer((_) async => Future.value());

      await repo.unSubscribe(symbol);

      verify(mockDataSource.unSubscribe(symbol)).called(1);
    });

    test('getStream returns a mapped stream of TickerEntity list', () async {
      final dummyEvent =
          '{"data": [{"p": 100.0, "s": "AAPL", "t": 123456789.0, "v": 10.0}]}';

      final streamController = StreamController<dynamic>();
      when(
        mockDataSource.getStream(),
      ).thenAnswer((_) async => streamController.stream);

      final dummyTickerEntity = TickerEntity(
        p: 100.0,
        s: 'AAPL',
        t: 123456789.0,
        v: 10.0,
      );
      final expectedList = [dummyTickerEntity];

      when(mockTickerListMapper.fromJson(any)).thenReturn(expectedList);

      final resultStream = await repo.getStream();

      final completer = Completer<List<TickerEntity>>();
      resultStream!.listen((data) {
        completer.complete(data);
      });

      streamController.add(dummyEvent);
      final result = await completer.future;

      expect(result, expectedList);
      verify(mockDataSource.getStream()).called(1);
      verify(mockTickerListMapper.fromJson(any)).called(1);

      await streamController.close();
    });

    test('getStream propagates exceptions from dataSource', () async {
      when(mockDataSource.getStream()).thenThrow(Exception('Test error'));

      expect(repo.getStream(), throwsA(isA<Exception>()));
      verify(mockDataSource.getStream()).called(1);
    });
  });
}
