import 'package:ft/features/history/domain/entity/historical_data.dart';

abstract class HistoricalDataRepository {
  Future<List<HistoricalData>> getHistoricalData(String symbol);
}
