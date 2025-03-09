import 'package:ft/features/history/domain/entity/historical_data.dart';
import 'package:ft/features/history/domain/repository/historical_data_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class HistoricalDataRepositoryUseCase {
  final HistoricalDataRepository _historicalDataRepository;

  HistoricalDataRepositoryUseCase(this._historicalDataRepository);

  Future<List<HistoricalData>> call(String symbol) async {
    try {
      final response = await _historicalDataRepository.getHistoricalData(
        symbol,
      );
      return response;
    } catch (e) {
      //TODO
      rethrow;
    }
  }
}
