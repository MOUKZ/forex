import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft/core/injection/injection_config.dart';
import 'package:ft/features/forex_pairs/domain/entity/forex_pair.dart';
import 'package:ft/features/history/domain/entity/historical_data.dart';
import 'package:ft/features/history/presentation/bloc/historical_data_bloc.dart';
import 'package:ft/features/history/presentation/widget/indicator_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryPage extends StatefulWidget {
  final ForexPair forexPair;

  HistoryPage({required this.forexPair});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final HistoricalDataBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc =
        getIt<HistoricalDataBloc>()
          ..add(GetHistoricalDataEvent(widget.forexPair.symbol));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Historical EPS Surprises')),
      body: BlocBuilder<HistoricalDataBloc, HistoricalDataState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is HistoricalDataWithData) {
            return Column(
              children: [
                Text(
                  'AAPL',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IndicatorWidget(color: Colors.red, title: 'Actual'),
                    SizedBox(width: 10),
                    IndicatorWidget(color: Colors.amber, title: 'Estimate'),
                  ],
                ),
                Expanded(
                  child: SfCartesianChart(
                    enableSideBySideSeriesPlacement: true,

                    primaryXAxis: DateTimeAxis(),
                    series: <CartesianSeries>[
                      // Renders scatter chart
                      ScatterSeries<HistoricalData, DateTime>(
                        dataSource: state.list,
                        xValueMapper:
                            (HistoricalData data, _) =>
                                DateTime.tryParse(data.period),
                        yValueMapper: (HistoricalData data, _) => data.estimate,
                        color: Colors.amber,
                      ),
                      ScatterSeries<HistoricalData, DateTime>(
                        dataSource: state.list,
                        xValueMapper:
                            (HistoricalData data, _) =>
                                DateTime.tryParse(data.period),
                        yValueMapper: (HistoricalData data, _) => data.actual,
                        color: Colors.red,
                        markerSettings: MarkerSettings(width: 10, height: 10),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
