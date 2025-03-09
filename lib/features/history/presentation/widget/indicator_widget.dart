import 'package:flutter/material.dart';

class IndicatorWidget extends StatelessWidget {
  final String title;
  final Color color;
  const IndicatorWidget({super.key, required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20, // Set width
          height: 20, // Set height
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle, // Makes the container circular
          ),
        ),
        SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }
}
