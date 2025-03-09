import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ArrowShimmer extends StatelessWidget {
  const ArrowShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: const Icon(
        Icons.arrow_upward,
      ),
    );
  }
}
