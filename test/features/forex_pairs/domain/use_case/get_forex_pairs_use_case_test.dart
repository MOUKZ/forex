// get_forex_pairs_use_case_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:ft/features/forex_pairs/domain/entity/forex_pair.dart';
import 'package:ft/features/forex_pairs/domain/repository/forex_pairs_repository.dart';
import 'package:ft/features/forex_pairs/domain/use_cases/get_forex_pairs_use_case.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ForexPairsRepository])
import 'get_forex_pairs_use_case_test.mocks.dart';

void main() {
  late GetForexPairsUseCase useCase;
  late MockForexPairsRepository mockRepository;

  setUp(() {
    mockRepository = MockForexPairsRepository();
    useCase = GetForexPairsUseCase(mockRepository);
  });

  group('GetForexPairsUseCase', () {
    test(
      'should return a list of ForexPair when repository returns data',
      () async {
        final testForexPairs = [
          ForexPair(
            symbol: 'BINANCE:QTUMBTC',
            description: 'Binance QTUM/BTC',
            displaySymbol: 'QTUM/BTC',
          ),
        ];

        when(
          mockRepository.getForexPairs(),
        ).thenAnswer((_) async => testForexPairs);

        final result = await useCase();

        expect(result, testForexPairs);
        verify(mockRepository.getForexPairs()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test('should rethrow exception when repository throws an error', () async {
      final testException = Exception('Test error');
      when(mockRepository.getForexPairs()).thenThrow(testException);

      expect(() async => await useCase(), throwsA(testException));
      verify(mockRepository.getForexPairs()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
