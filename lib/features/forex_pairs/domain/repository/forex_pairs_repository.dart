import 'package:ft/features/forex_pairs/domain/entity/forex_pair.dart';

abstract class ForexPairsRepository {
  Future<List<ForexPair>> getForexPairs();
}
