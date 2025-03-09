import 'package:flutter/material.dart';
import 'package:ft/core/injection/injection_config.dart';
import 'package:ft/features/forex_pairs/presentation/forex_pairs_list/forex_pairs_page.dart';

void main() {
  configureDependencies();
  runApp(FXTMApp());
}

class FXTMApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FXTM Forex Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ForexPairsPage(),
    );
  }
}
