import 'package:ft/features/ticker/domain/entity/ticket_entity.dart';

abstract class WebSocketRepository {
  Future<void> subscribe(String symbol);
  Future<void> unSubscribe(String symbol);

  Future<void> disconnect();
  Future<Stream<List<TickerEntity>?>?> getStream();
}
