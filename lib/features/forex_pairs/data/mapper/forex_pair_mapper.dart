import 'package:ft/features/forex_pairs/data/response/forex_pair_reponse.dart';
import 'package:ft/features/forex_pairs/domain/entity/forex_pair.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ForexPairMapper {
  List<ForexPair> map(List<ForexPairResponse> response) {
    return response
        .map(
          (item) => ForexPair(
            symbol: item.symbol,
            description: item.description,
            displaySymbol: item.displaySymbol,
          ),
        )
        .toList();
  }
}
