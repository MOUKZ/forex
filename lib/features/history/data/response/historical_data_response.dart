class HistoricalDataResponse {
  final double actual;
  final double estimate;
  final String period;
  final int quarter;
  final double surprise;
  final double surprisePercent;
  final String symbol;
  final int year;

  HistoricalDataResponse({
    required this.actual,
    required this.estimate,
    required this.period,
    required this.quarter,
    required this.surprise,
    required this.surprisePercent,
    required this.symbol,
    required this.year,
  });

  factory HistoricalDataResponse.fromJson(Map<String, dynamic> json) {
    return HistoricalDataResponse(
      actual: (json['actual'] as num).toDouble(),
      estimate: (json['estimate'] as num).toDouble(),
      period: json['period'] as String,
      quarter: json['quarter'] as int,
      surprise: (json['surprise'] as num).toDouble(),
      surprisePercent: (json['surprisePercent'] as num).toDouble(),
      symbol: json['symbol'] as String,
      year: json['year'] as int,
    );
  }
}
