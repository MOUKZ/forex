part of 'ticker_bloc_bloc.dart';

sealed class TickerBlocState {}

final class TickerBlocInitial extends TickerBlocState {}

final class UpdateTickerState extends TickerBlocState {
  final PresentationTickerEntity? ticker;

  UpdateTickerState({required this.ticker});
}
