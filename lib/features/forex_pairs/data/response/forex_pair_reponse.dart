class ForexPairResponse {
  String description;
  String displaySymbol;
  String symbol;

  ForexPairResponse({
    required this.description,
    required this.displaySymbol,
    required this.symbol,
  });

  factory ForexPairResponse.fromJson(Map<String, dynamic> json) {
    return ForexPairResponse(
      symbol: json['symbol'],
      description: json['description'],
      displaySymbol: json['displaySymbol'],
    );
  }
}
