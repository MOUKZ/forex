import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerText extends StatelessWidget {
  final String text;
  const ShimmerText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black26,
      highlightColor: Colors.grey.shade100,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
