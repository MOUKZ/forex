import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft/core/injection/injection_config.dart';
import 'package:ft/features/forex_pairs_bottom_nav_bar/presentation/widgets/forex_bottom_nav_bar.dart';
import 'package:ft/features/forex_pairs/presentation/forex_pairs_list/bloc/forex_pairs_bloc.dart';
import 'package:ft/features/ticker/presentation/widgets/forex_ticker_item.dart';

class ForexPairsPage extends StatefulWidget {
  const ForexPairsPage({super.key});

  @override
  State<ForexPairsPage> createState() => _ForexPairsPageState();
}

class _ForexPairsPageState extends State<ForexPairsPage> {
  late final ForexPairsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<ForexPairsBloc>();
    _bloc.add(LoadForexPairsEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FXTM Forex Tracker')),
      bottomNavigationBar: const ForexBottomNavBar(),
      body: BlocBuilder<ForexPairsBloc, ForexPairsState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is ForexPairsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ForexPairsWithData) {
            return ListView.builder(
              itemCount: state.pairs.length,
              itemBuilder: (context, index) {
                final pair = state.pairs[index];
                return ForexTickerItem(pair: pair);
              },
            );
          } else {
            return const Center(child: Text('Failed to load forex pairs.'));
          }
        },
      ),
    );
  }
}
