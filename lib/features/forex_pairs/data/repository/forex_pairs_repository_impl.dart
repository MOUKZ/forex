import 'package:ft/features/forex_pairs/data/data_source/forex_pairs_data_remote_source.dart';
import 'package:ft/features/forex_pairs/data/mapper/forex_pair_mapper.dart';
import 'package:ft/features/forex_pairs/domain/entity/forex_pair.dart';
import 'package:ft/features/forex_pairs/domain/repository/forex_pairs_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForexPairsRepository)
class ForexPairsRepositoryIMPL extends ForexPairsRepository {
  final ForexPairsRemoteDataSource dataSource;
  final ForexPairMapper mapper;

  ForexPairsRepositoryIMPL(this.dataSource, this.mapper);

  @override
  Future<List<ForexPair>> getForexPairs() async {
    try {
      final response = await dataSource.getForexPairs();
      return mapper.map(response);
    } catch (e) {
      //TODO: Handle error and add mapper from data error to domain error
      throw e;
    }
  }
}
