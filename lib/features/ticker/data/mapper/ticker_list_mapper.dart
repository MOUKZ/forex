import 'package:ft/features/ticker/data/mapper/ticker_mapper.dart';
import 'package:ft/features/ticker/data/response/web_socket_response.dart';
import 'package:ft/features/ticker/domain/entity/ticket_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class TickerListMapper {
  final TickerMapper _tickerMapper;
  TickerListMapper(this._tickerMapper);

  List<TickerEntity> fromJson(WebSocketResponse response) {
    final tickerResponse = response.data;
    return tickerResponse?.map((e) => _tickerMapper.fromJson(e)).toList() ?? [];
  }
}
