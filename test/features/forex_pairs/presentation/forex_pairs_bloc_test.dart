// test/features/forex_pairs/presentation/bloc/forex_pairs_bloc_test.dart

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ft/features/forex_pairs/domain/entity/forex_pair.dart';
import 'package:ft/features/forex_pairs/domain/use_cases/get_forex_pairs_use_case.dart';
import 'package:ft/features/forex_pairs/presentation/forex_pairs_list/bloc/forex_pairs_bloc.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([GetForexPairsUseCase])
import 'forex_pairs_bloc_test.mocks.dart';

void main() {
  late MockGetForexPairsUseCase mockGetForexPairsUseCase;
  late ForexPairsBloc forexPairsBloc;

  setUp(() {
    mockGetForexPairsUseCase = MockGetForexPairsUseCase();
    forexPairsBloc = ForexPairsBloc(mockGetForexPairsUseCase);
  });

  group('ForexPairsBloc', () {
    test('initial state is ForexPairsLoading', () {
      expect(forexPairsBloc.state, isA<ForexPairsLoading>());
    });

    blocTest<ForexPairsBloc, ForexPairsState>(
      'emits [ForexPairsLoading, ForexPairsWithData] when use case returns data',
      build: () {
        when(mockGetForexPairsUseCase()).thenAnswer(
          (_) async => [
            ForexPair(
              symbol: 'AAPL',
              description: 'Apple Inc.',
              displaySymbol: 'AAPL',
            ),
          ],
        );
        return forexPairsBloc;
      },
      act: (bloc) => bloc.add(LoadForexPairsEvent()),
      expect: () => [isA<ForexPairsLoading>(), isA<ForexPairsWithData>()],
      verify: (_) {
        verify(mockGetForexPairsUseCase()).called(1);
      },
    );

    blocTest<ForexPairsBloc, ForexPairsState>(
      'emits [ForexPairsLoading, ForexPairsFailed] when use case throws an exception',
      build: () {
        when(mockGetForexPairsUseCase()).thenThrow(Exception('Test error'));
        return forexPairsBloc;
      },
      act: (bloc) => bloc.add(LoadForexPairsEvent()),
      expect: () => [isA<ForexPairsLoading>(), isA<ForexPairsFailed>()],
      verify: (_) {
        verify(mockGetForexPairsUseCase()).called(1);
      },
    );
  });
}
