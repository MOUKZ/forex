part of 'forex_pairs_bloc.dart';

sealed class ForexPairsState {}

final class ForexPairsLoading extends ForexPairsState {}

final class ForexPairsWithData extends ForexPairsState {
  final List<ForexPair> pairs;

  ForexPairsWithData(this.pairs);
}

final class ForexPairsFailed extends ForexPairsState {}
