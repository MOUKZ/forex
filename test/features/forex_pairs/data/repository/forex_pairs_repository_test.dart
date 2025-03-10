// forex_pairs_repository_impl_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:ft/core/exception/forex_exceptions.dart';
import 'package:ft/features/forex_pairs/data/data_source/forex_pairs_data_remote_source.dart';
import 'package:ft/features/forex_pairs/data/mapper/forex_pair_mapper.dart';
import 'package:ft/features/forex_pairs/data/repository/forex_pairs_repository_impl.dart';
import 'package:ft/features/forex_pairs/data/response/forex_pair_reponse.dart';
import 'package:ft/features/forex_pairs/domain/entity/forex_pair.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ForexPairsRemoteDataSource, ForexPairMapper])
import 'forex_pairs_repository_test.mocks.dart';

void main() {
  late ForexPairsRepositoryIMPL repository;
  late MockForexPairsRemoteDataSource mockDataSource;
  late MockForexPairMapper mockMapper;

  setUp(() {
    mockDataSource = MockForexPairsRemoteDataSource();
    mockMapper = MockForexPairMapper();
    repository = ForexPairsRepositoryIMPL(mockDataSource, mockMapper);
  });

  group('ForexPairsRepositoryIMPL', () {
    final List<ForexPairResponse> remoteResponse = [
      ForexPairResponse(
        description: "Binance QTUM/BTC",
        displaySymbol: "QTUM/BTC",
        symbol: "BINANCE:QTUMBTC",
      ),
    ];
    final forexPair = ForexPair(
      symbol: "BINANCE:QTUMBTC",
      description: "Binance QTUM/BTC",
      displaySymbol: "QTUM/BTC",
    );
    final expectedForexPairs = [forexPair];

    test(
      'should return list of ForexPair when data source returns data',
      () async {
        when(
          mockDataSource.getForexPairs(),
        ).thenAnswer((_) async => remoteResponse);
        when(mockMapper.map(remoteResponse)).thenReturn(expectedForexPairs);

        final result = await repository.getForexPairs();

        expect(result, expectedForexPairs);
        verify(mockDataSource.getForexPairs()).called(1);
        verify(mockMapper.map(remoteResponse)).called(1);
        verifyNoMoreInteractions(mockDataSource);
        verifyNoMoreInteractions(mockMapper);
      },
    );

    test(
      'should rethrow ForexException when data source throws ForexException',
      () async {
        final forexException = UnKnownException();
        when(mockDataSource.getForexPairs()).thenThrow(forexException);

        expect(() => repository.getForexPairs(), throwsA(forexException));
        verify(mockDataSource.getForexPairs()).called(1);
        verifyZeroInteractions(mockMapper);
      },
    );

    test(
      'should rethrow Exception when data source throws generic Exception',
      () async {
        final genericException = Exception("Generic error");
        when(mockDataSource.getForexPairs()).thenThrow(genericException);

        expect(() => repository.getForexPairs(), throwsA(genericException));
        verify(mockDataSource.getForexPairs()).called(1);
        verifyZeroInteractions(mockMapper);
      },
    );
  });
}
