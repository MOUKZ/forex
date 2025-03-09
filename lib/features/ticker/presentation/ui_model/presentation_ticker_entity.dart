class PresentationTickerEntity {
  final double currentPrice;
  final double percentChange;
  final double change;

  PresentationTickerEntity(
      {required this.change,
      required this.currentPrice,
      required this.percentChange});
}
