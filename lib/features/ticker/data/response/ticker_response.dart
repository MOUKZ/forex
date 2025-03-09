class TickerResponse {
  double? p;
  String? s;
  double? t;
  double? v;

  TickerResponse({this.p, this.s, this.t, this.v});

  TickerResponse.fromJson(Map<String, dynamic> json) {
    p = double.tryParse(json['p'].toString());
    s = json['s'];
    t = double.tryParse(json['t'].toString());
    v = double.tryParse(json['v'].toString());
  }
}
