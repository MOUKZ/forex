import 'package:flutter/material.dart';
import 'package:ft/features/forex_pairs/domain/entity/forex_pair.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryPage extends StatelessWidget {
  final ForexPair forexPair;

  HistoryPage({required this.forexPair});
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(DateTime(2010), 32),
      ChartData(DateTime(2011), 40),
      ChartData(DateTime(2012), 34),
      ChartData(DateTime(2013), 52),
      ChartData(DateTime(2014), 42),
      ChartData(DateTime(2015), 38),
      ChartData(DateTime(2016), 41),
    ];
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            series: <CartesianSeries>[
              // Renders scatter chart
              ScatterSeries<ChartData, DateTime>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final DateTime x;
  final int y;

  ChartData(this.x, this.y);
}
