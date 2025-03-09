import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft/features/forex_pairs_bottom_nav_bar/domain/enums/bottom_navigation_type.dart';
import 'package:injectable/injectable.dart';

part 'forex_pairs_bottom_nav_bar_event.dart';
part 'forex_pairs_bottom_nav_bar_state.dart';

@Injectable()
class ForexPairsBottomNavBarBloc
    extends Bloc<ForexPairsBottomNavBarEvent, ForexPairsBottomNavBarState> {
  ForexPairsBottomNavBarBloc() : super(ForexPairsBottomNavBarMarketsState()) {
    on<ChangeBottomNavBarTap>(_onChangeBottomNavBarTap);
  }

  FutureOr<void> _onChangeBottomNavBarTap(event, emit) {
    switch (event.selectedType) {
      case BottomNavigationType.markets:
        emit(ForexPairsBottomNavBarMarketsState());

        break;
      case BottomNavigationType.news:
        emit(ForexPairsBottomNavBarNewsState());
        break;
      case BottomNavigationType.settings:
        emit(ForexPairsBottomNavBarSettingsState());
        break;
      default:
        emit(ForexPairsBottomNavBarMarketsState());
    }
  }
}
