part of 'forex_pairs_bottom_nav_bar_bloc.dart';

sealed class ForexPairsBottomNavBarEvent {}

class ChangeBottomNavBarTap extends ForexPairsBottomNavBarEvent {
  final BottomNavigationType selectedType;
  ChangeBottomNavBarTap({required this.selectedType});
}
