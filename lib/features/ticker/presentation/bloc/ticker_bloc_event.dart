part of 'ticker_bloc_bloc.dart';

sealed class TickerBlocEvent {}

class InitSubscription extends TickerBlocEvent {
  final String symbol;

  InitSubscription(this.symbol);
}

class CloseSubscription extends TickerBlocEvent {
  final String symbol;

  CloseSubscription(this.symbol);
}

class UpdateTickerEvent extends TickerBlocEvent {
  final PresentationTickerEntity? ticker;

  UpdateTickerEvent(this.ticker);
}
