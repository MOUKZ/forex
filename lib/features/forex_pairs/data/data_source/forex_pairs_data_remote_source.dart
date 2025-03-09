import 'package:ft/core/dio/dio_client.dart';
import 'package:ft/features/forex_pairs/data/response/forex_pair_reponse.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ForexPairsRemoteDataSource {
  final DioClient _dio;

  ForexPairsRemoteDataSource(this._dio);

  Future<List<ForexPairResponse>> getForexPairs() async {
    final dioResponse = await _dio.get(
      'https://finnhub.io/api/v1/forex/symbol?exchange=oanda&token=cv6uripr01qsq4644de0cv6uripr01qsq4644deg',
    );

    if (dioResponse.statusCode == 200) {
      // Ensure the response data is a List.
      final List<dynamic> data =
          dioResponse.data is List ? dioResponse.data : [];
      return data
          .map(
            (json) => ForexPairResponse.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw Exception('Failed to load forex pairs');
    }
  }
}
