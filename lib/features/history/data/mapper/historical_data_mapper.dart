import 'package:ft/features/history/data/response/historical_data_response.dart';
import 'package:ft/features/history/domain/entity/historical_data.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class HistoricalDataMapper {
  List<HistoricalData> map(List<HistoricalDataResponse> response) {
    return response
        .map(
          (item) => HistoricalData(
            actual: item.actual,
            estimate: item.estimate,
            period: item.period,
            quarter: item.quarter,
            surprise: item.surprise,
            surprisePercent: item.surprisePercent,
            symbol: item.symbol,
            year: item.year,
          ),
        )
        .toList();
  }
}
