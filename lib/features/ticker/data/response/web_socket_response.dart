import 'package:ft/features/ticker/data/response/ticker_response.dart';

class WebSocketResponse {
  List<TickerResponse>? data;
  String? type;

  WebSocketResponse({this.data, this.type});

  WebSocketResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TickerResponse>[];
      json['data'].forEach((v) {
        data!.add(TickerResponse.fromJson(v));
      });
    }
    type = json['type'];
  }
}
