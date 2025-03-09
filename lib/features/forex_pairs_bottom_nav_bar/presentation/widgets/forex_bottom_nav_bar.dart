import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft/core/injection/injection_config.dart';
import 'package:ft/features/forex_pairs_bottom_nav_bar/domain/enums/bottom_navigation_type.dart';
import 'package:ft/features/forex_pairs_bottom_nav_bar/presentation/bloc/forex_pairs_bottom_nav_bar_bloc.dart';

class ForexBottomNavBar extends StatefulWidget {
  const ForexBottomNavBar({super.key});

  @override
  State<ForexBottomNavBar> createState() => _ForexBottomNavBarState();
}

class _ForexBottomNavBarState extends State<ForexBottomNavBar> {
  late final ForexPairsBottomNavBarBloc _forexPairsBottomNavBarBloc;

  @override
  void initState() {
    _forexPairsBottomNavBarBloc = getIt<ForexPairsBottomNavBarBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _forexPairsBottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      ForexPairsBottomNavBarBloc,
      ForexPairsBottomNavBarState
    >(
      bloc: _forexPairsBottomNavBarBloc,
      buildWhen:
          (previous, current) =>
              previous != current &&
              current is ForexPairsBottomNavBarMarketsState,
      listenWhen:
          (previous, current) =>
              previous != current &&
              current is! ForexPairsBottomNavBarMarketsState,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This menu item is disabled')),
        );
      },
      builder: (context, state) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Markets',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _getCurrentIndex(state),
          onTap: (index) {
            _forexPairsBottomNavBarBloc.add(
              ChangeBottomNavBarTap(
                selectedType: BottomNavigationType.values[index],
              ),
            );
          },
        );
      },
    );
  }
}

int _getCurrentIndex(ForexPairsBottomNavBarState state) {
  if (state is ForexPairsBottomNavBarMarketsState) {
    return 0;
  } else if (state is ForexPairsBottomNavBarNewsState) {
    return 1;
  } else if (state is ForexPairsBottomNavBarSettingsState) {
    return 2;
  } else {
    return 0;
  }
}
