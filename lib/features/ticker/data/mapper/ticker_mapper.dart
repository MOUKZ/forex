import 'package:ft/features/ticker/data/response/ticker_response.dart';
import 'package:ft/features/ticker/domain/entity/ticket_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class TickerMapper {
  TickerEntity fromJson(TickerResponse response) {
    return TickerEntity(
      p: response.p,
      s: response.s,
      t: response.t,
      v: response.v,
    );
  }
}
