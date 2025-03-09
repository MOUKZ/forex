import 'dart:convert';

import 'package:ft/features/ticker/data/data_source/web_socket_data_source.dart';
import 'package:ft/features/ticker/data/mapper/ticker_list_mapper.dart';
import 'package:ft/features/ticker/data/response/web_socket_response.dart';
import 'package:ft/features/ticker/domain/entity/ticket_entity.dart';
import 'package:ft/features/ticker/domain/repository/web_socket_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WebSocketRepository)
class WebSocketRepoImpl extends WebSocketRepository {
  final TickerListMapper _tickerListMapper;
  final WebSocketDataSource _webSocketDataSource;

  WebSocketRepoImpl(this._webSocketDataSource, this._tickerListMapper);

  @override
  Future<void> disconnect() async {
    await _webSocketDataSource.close();
  }

  @override
  Future<Stream<List<TickerEntity>?>?> getStream() async {
    final stream = await _webSocketDataSource.getStream();

    return stream?.map((event) {
      return _tickerListMapper
          .fromJson(WebSocketResponse.fromJson(jsonDecode(event)))
          .toList();
    });
  }

  @override
  Future<void> subscribe(String symbol) {
    return _webSocketDataSource.subscribe(symbol);
  }

  @override
  Future<void> unSubscribe(String symbol) {
    return _webSocketDataSource.unSubscribe(symbol);
  }
}
