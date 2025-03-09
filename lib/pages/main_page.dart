// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:ft/features/forex_pairs/domain/entity/forex_pair.dart';
// import 'package:ft/features/forex_pairs/presentation/forex_pairs_bottom_nav_bar/forex_bottom_nav_bar.dart';
// import 'package:ft/features/forex_pairs/presentation/widgets/forex_pair_list_item.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   List<ForexPair> _forexPairs = [];
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();

//     // Simulate real-time price updates every 5 seconds
//     _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       _updatePrices();
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   void _updatePrices() {
//     // TODO: Replace this simulation with real-time price updates from Finnhub API
//     setState(() {
//       _forexPairs = _forexPairs.map((pair) {
//         // Simulate price change
//         double change =
//             (0.0001 * (1 - 2 * (DateTime.now().second % 2))).toDouble();
//         double newPrice = pair.currentPrice + change;
//         return ForexPair(
//           symbol: pair.symbol,
//           currentPrice: newPrice,
//           change: change,
//           percentChange: (change / pair.currentPrice) * 100,
//         );
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('FXTM Forex Tracker'),
//       ),
//       body: _buildBody(),
//       bottomNavigationBar: const ForexBottomNavBar(),
//     );
//   }

//   Widget _buildBody() {
//     if (_forexPairs.isEmpty) {
//       return const Center(child: CircularProgressIndicator());
//     } else {
//       return ListView.separated(
//         itemCount: _forexPairs.length,
//         separatorBuilder: (context, index) => const Divider(height: 1),
//         itemBuilder: (context, index) =>
//             ForexTickerItem(pair: _forexPairs[index]),
//       );
//     }
//   }
// }
