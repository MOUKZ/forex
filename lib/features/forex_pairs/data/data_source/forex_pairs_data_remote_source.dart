import 'package:ft/core/constants.dart';
import 'package:ft/core/dio/dio_client.dart';
import 'package:ft/core/exception/forex_exceptions.dart';
import 'package:ft/features/forex_pairs/data/response/forex_pair_reponse.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ForexPairsRemoteDataSource {
  final DioClient _dio;

  ForexPairsRemoteDataSource(this._dio);

  Future<List<ForexPairResponse>> getForexPairs() async {
    final dioResponse = await _dio.get(
      'https://finnhub.io/api/v1/forex/symbol?exchange=oanda&token=$key',
    );

    if (dioResponse.statusCode == 200) {
      // Ensure the response data is a List.
      try {
        final List<dynamic> data =
            dioResponse.data is List ? dioResponse.data : [];
        return data
            .map(
              (json) =>
                  ForexPairResponse.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      } catch (e) {
        throw ForexPairsResponseExceptions();
      }
    } else {
      throw UnKnownException();
    }
  }
}
