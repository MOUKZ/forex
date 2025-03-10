// test/features/forex_pairs/data/data_source/forex_pairs_remote_data_source_test.dart

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ft/core/dio/dio_client.dart';
import 'package:ft/core/exception/forex_exceptions.dart';
import 'package:ft/features/forex_pairs/data/data_source/forex_pairs_data_remote_source.dart';
import 'package:ft/features/forex_pairs/data/response/forex_pair_reponse.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([DioClient])
import 'forex_pairs_data_remote_source_test.mocks.dart';

void main() {
  late ForexPairsRemoteDataSource remoteDataSource;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    remoteDataSource = ForexPairsRemoteDataSource(mockDioClient);
  });

  group('getForexPairs', () {
    test(
      'returns list of ForexPairResponse when status code is 200 and data is valid',
      () async {
        final sampleJson = [
          {
            "description": "Binance QTUM/BTC",
            "displaySymbol": "QTUM/BTC",
            "symbol": "BINANCE:QTUMBTC",
          },
        ];

        // Create a successful response.
        final response = Response(
          data: sampleJson,
          statusCode: 200,
          requestOptions: RequestOptions(
            path:
                'https://finnhub.io/api/v1/forex/symbol?exchange=oanda&token=cv6uripr01qsq4644de0cv6uripr01qsq4644deg',
          ),
        );
        when(mockDioClient.get(any)).thenAnswer((_) async => response);

        // Act
        final result = await remoteDataSource.getForexPairs();

        // Assert
        expect(result, isA<List<ForexPairResponse>>());
        expect(result.length, equals(1));
        expect(result.first.symbol, equals("BINANCE:QTUMBTC"));
      },
    );

    test('throws UnKnownException when status code is not 200', () async {
      final response = Response(
        data: "Error",
        statusCode: 404,
        requestOptions: RequestOptions(
          path:
              'https://finnhub.io/api/v1/forex/symbol?exchange=oanda&token=cv6uripr01qsq4644de0cv6uripr01qsq4644deg',
        ),
      );
      when(mockDioClient.get(any)).thenAnswer((_) async => response);

      // Act & Assert
      expect(
        remoteDataSource.getForexPairs(),
        throwsA(isA<UnKnownException>()),
      );
    });

    test('throws ForexPairsResponseExceptions when mapping fails', () async {
      final response = Response(
        data: "Not a list",
        statusCode: 404,
        requestOptions: RequestOptions(
          path:
              'https://finnhub.io/api/v1/forex/symbol?exchange=oanda&token=cv6uripr01qsq4644de0cv6uripr01qsq4644deg',
        ),
      );
      when(mockDioClient.get(any)).thenAnswer((_) async => response);

      // Act & Assert
      expect(
        remoteDataSource.getForexPairs(),
        throwsA(isA<UnKnownException>()),
      );
    });
  });
}
