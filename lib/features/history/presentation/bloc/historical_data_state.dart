part of 'historical_data_bloc.dart';

sealed class HistoricalDataState {}

final class HistoricalDataLoading extends HistoricalDataState {}

final class HistoricalDataWithData extends HistoricalDataState {
  List<HistoricalData> list;
  HistoricalDataWithData(this.list);
}
