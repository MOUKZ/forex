import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft/core/injection/injection_config.dart';
import 'package:ft/features/forex_pairs/domain/entity/forex_pair.dart';
import 'package:ft/features/ticker/presentation/bloc/ticker_bloc_bloc.dart';
import 'package:ft/features/ticker/presentation/widgets/arrow_shimmer.dart';
import 'package:ft/features/ticker/presentation/widgets/price_shimmer.dart';

import 'package:ft/pages/history_page.dart';

class ForexTickerItem extends StatefulWidget {
  final ForexPair pair;

  const ForexTickerItem({Key? key, required this.pair}) : super(key: key);

  @override
  State<ForexTickerItem> createState() => _ForexTickerItemState();
}

class _ForexTickerItemState extends State<ForexTickerItem> {
  late final TickerBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<TickerBloc>();
    _bloc.add(InitSubscription(widget.pair.symbol));
  }

  @override
  void dispose() {
    _bloc.add(CloseSubscription(widget.pair.symbol));
    _bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: BlocBuilder<TickerBloc, TickerBlocState>(
        bloc: _bloc,
        buildWhen:
            (previous, current) =>
                current is UpdateTickerState && current.ticker?.change != null,
        builder: (context, state) {
          if (state is UpdateTickerState) {
            return Icon(
              _getArrowIcon(state.ticker?.change ?? 0),
              color: _getArrowColor(state.ticker?.change ?? 0),
            );
          } else {
            return const ArrowShimmer();
          }
        },
      ),
      title: Text(
        widget.pair.displaySymbol,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      subtitle: BlocBuilder<TickerBloc, TickerBlocState>(
        bloc: _bloc,
        buildWhen:
            (previous, current) =>
                current is UpdateTickerState &&
                current.ticker?.currentPrice != null,
        builder: (context, state) {
          if (state is UpdateTickerState) {
            return Text(
              'Price: ${state.ticker?.currentPrice.toStringAsFixed(4)}',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            );
          } else {
            return const ShimmerText(text: 'Price: 000');
          }
        },
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          BlocBuilder<TickerBloc, TickerBlocState>(
            bloc: _bloc,
            buildWhen:
                (previous, current) =>
                    current is UpdateTickerState &&
                    current.ticker?.change != null,
            builder: (context, state) {
              if (state is UpdateTickerState) {
                return Text(
                  '${_isPriceUp(state.ticker?.change ?? 0) ? '+' : ''}${(state).ticker?.change.toStringAsFixed(4)}',
                  style: TextStyle(
                    color: _getArrowColor(state.ticker?.change ?? 0),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                );
              } else {
                return const ShimmerText(text: '0000');
              }
            },
          ),
          BlocBuilder<TickerBloc, TickerBlocState>(
            bloc: _bloc,
            buildWhen:
                (previous, current) =>
                    current is UpdateTickerState &&
                    current.ticker?.change != null &&
                    current.ticker?.percentChange != null,
            builder: (context, state) {
              if (state is UpdateTickerState) {
                return Text(
                  '${_isPriceUp(state.ticker?.change ?? 0) ? '+' : ''}${state.ticker?.percentChange.toStringAsFixed(4)}%',
                  style: TextStyle(
                    color: _getArrowColor((state).ticker?.change ?? 0),
                    fontSize: 12,
                  ),
                );
              } else {
                return const ShimmerText(text: '0.0%');
              }
            },
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistoryPage(forexPair: widget.pair),
          ),
        );
      },
    );
  }

  bool _isPriceUp(double change) => change > 0;

  IconData _getArrowIcon(double price) =>
      _isPriceUp(price) ? Icons.arrow_upward : Icons.arrow_downward;

  Color _getArrowColor(double price) =>
      _isPriceUp(price) ? Colors.green : Colors.red;
}
