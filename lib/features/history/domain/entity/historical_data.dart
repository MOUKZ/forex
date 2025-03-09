class HistoricalData {
  final double actual;
  final double estimate;
  final String period;
  final int quarter;
  final double surprise;
  final double surprisePercent;
  final String symbol;
  final int year;

  HistoricalData({
    required this.actual,
    required this.estimate,
    required this.period,
    required this.quarter,
    required this.surprise,
    required this.surprisePercent,
    required this.symbol,
    required this.year,
  });
}
