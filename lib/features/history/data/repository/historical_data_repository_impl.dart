import 'package:ft/core/exception/forex_exceptions.dart';
import 'package:ft/features/history/data/data_source/historical_data_data_source.dart';
import 'package:ft/features/history/data/mapper/historical_data_mapper.dart';
import 'package:ft/features/history/domain/entity/historical_data.dart';
import 'package:ft/features/history/domain/repository/historical_data_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HistoricalDataRepository)
class HistoricalDataRepositoryIMPL extends HistoricalDataRepository {
  final HistoricalDataDataSource dataSource;
  final HistoricalDataMapper mapper;

  HistoricalDataRepositoryIMPL(this.dataSource, this.mapper);

  @override
  Future<List<HistoricalData>> getHistoricalData(String symbol) async {
    try {
      final response = await dataSource.getHistoricalData(symbol);
      return mapper.map(response);
    } on ForexException catch (_) {
      rethrow;
    } on Exception catch (_) {
      // here we can use sentry for logging
      rethrow;
    }
  }
}
