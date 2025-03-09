part of 'historical_data_bloc.dart';

sealed class HistoricalDataEvent {}

class GetHistoricalDataEvent extends HistoricalDataEvent {
  final String symbol;
  GetHistoricalDataEvent(this.symbol);
}
