import 'package:flutter_test/flutter_test.dart';
import 'package:ft/features/ticker/data/response/ticker_response.dart';
import 'package:ft/features/ticker/data/mapper/ticker_mapper.dart';

void main() {
  late TickerMapper mapper;

  setUp(() {
    mapper = TickerMapper();
  });

  test(
    'TickerMapper.fromJson maps TickerResponse to TickerEntity correctly',
    () {
      final response = TickerResponse(
        p: 100.0,
        s: 'AAPL',
        t: 1672531200.0,
        v: 5000.0,
      );

      final entity = mapper.fromJson(response);

      expect(entity.p, equals(100.0));
      expect(entity.s, equals('AAPL'));
      expect(entity.t, equals(1672531200.0));
      expect(entity.v, equals(5000.0));
    },
  );
}
