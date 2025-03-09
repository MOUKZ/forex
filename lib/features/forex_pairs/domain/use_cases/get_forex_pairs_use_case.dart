import 'package:ft/features/forex_pairs/domain/entity/forex_pair.dart';
import 'package:ft/features/forex_pairs/domain/repository/forex_pairs_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetForexPairsUseCase {
  final ForexPairsRepository _forexPairsRepository;

  GetForexPairsUseCase(this._forexPairsRepository);

  Future<List<ForexPair>> call() async {
    try {
      final response = await _forexPairsRepository.getForexPairs();
      return response;
    } catch (e) {
      //TODO
      rethrow;
    }
  }
}
