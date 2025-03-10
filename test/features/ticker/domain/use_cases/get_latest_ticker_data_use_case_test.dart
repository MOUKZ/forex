import 'package:flutter_test/flutter_test.dart';
import 'package:ft/features/ticker/domain/entity/ticket_entity.dart';
import 'package:ft/features/ticker/domain/use_cases/get_latest_ticker_data_use_case.dart';

void main() {
  late GetLatestTickerDataUseCase useCase;

  setUp(() {
    useCase = GetLatestTickerDataUseCase();
  });

  group('GetLatestTickerDataUseCase', () {
    test('returns null when no entries match the symbol', () {
      final entries = <TickerEntity>[
        TickerEntity(p: 100.0, s: 'GOOG', t: 100.0, v: 0),
        TickerEntity(p: 110.0, s: 'GOOG', t: 200.0, v: 0),
      ];

      final result = useCase.call(entries, 'AAPL');

      expect(result, isNull);
    });

    test(
      'returns PresentationTickerEntity with zero change when only one matching entry exists',
      () {
        // Arrange: Only one matching entry is provided.
        final entries = <TickerEntity>[
          TickerEntity(p: 100.0, s: 'AAPL', t: 100.0, v: 0),
          TickerEntity(p: 150.0, s: 'GOOG', t: 150.0, v: 0),
        ];

        final result = useCase.call(entries, 'AAPL');

        expect(result, isNotNull);
        expect(result!.change, equals(0));
        expect(result.percentChange, equals(0));
        expect(result.currentPrice, equals(100.0));
      },
    );

    test(
      'calculates correct change and percentChange for multiple matching entries',
      () {
        final entries = <TickerEntity>[
          TickerEntity(p: 100.0, s: 'AAPL', t: 100.0, v: 0),
          TickerEntity(p: 105.0, s: 'AAPL', t: 200.0, v: 0),
          TickerEntity(p: 150.0, s: 'GOOG', t: 250.0, v: 0),
        ];

        final result = useCase.call(entries, 'AAPL');

        expect(result, isNotNull);
        expect(result!.change, closeTo(5.0, 0.0001));
        expect(result.percentChange, closeTo(5.0, 0.0001));
        expect(result.currentPrice, equals(105.0));
      },
    );

    test(
      'returns zero change and percentChange if previous entry price is zero',
      () {
        final entries = <TickerEntity>[
          TickerEntity(p: 0.0, s: 'AAPL', t: 100.0, v: 0),
          TickerEntity(p: 105.0, s: 'AAPL', t: 200.0, v: 0),
        ];

        final result = useCase.call(entries, 'AAPL');

        expect(result, isNotNull);
        expect(result!.change, equals(0));
        expect(result.percentChange, equals(0));
        expect(result.currentPrice, equals(105.0));
      },
    );
  });
}
