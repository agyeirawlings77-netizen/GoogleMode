import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_theme.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  const ShimmerWidget({super.key, this.width = double.infinity, this.height = 16, this.borderRadius = 8});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.darkCard, highlightColor: AppTheme.darkBorder,
      child: Container(width: width, height: height, decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(borderRadius))));
  }

  static Widget list({int count = 4, double itemHeight = 60}) => Column(children: List.generate(count, (i) => Padding(padding: const EdgeInsets.only(bottom: 10), child: ShimmerWidget(height: itemHeight))));

  static Widget grid({int count = 8, double itemHeight = 80}) => GridView.count(crossAxisCount: 4, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 0.85, children: List.generate(count, (_) => const ShimmerWidget(height: 80)));
}
