import 'package:ft/core/constants.dart';
import 'package:ft/core/dio/dio_client.dart';
import 'package:ft/core/exception/forex_exceptions.dart';
import 'package:ft/features/history/data/response/historical_data_response.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class HistoricalDataDataSource {
  final DioClient _dio;

  HistoricalDataDataSource(this._dio);

  Future<List<HistoricalDataResponse>> getHistoricalData(String symbol) async {
    final dioResponse = await _dio.get(
      'https://finnhub.io/api/v1/stock/earnings?symbol=$symbol&token=$key',
    );

    if (dioResponse.statusCode == 200) {
      // Ensure the response data is a List.
      final List<dynamic> data =
          dioResponse.data is List ? dioResponse.data : [];
      return data
          .map(
            (json) =>
                HistoricalDataResponse.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } else {
      throw UnKnownException();
    }
  }
}
