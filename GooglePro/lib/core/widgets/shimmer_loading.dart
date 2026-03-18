import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_theme.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  const ShimmerLoading({super.key, this.width = double.infinity, this.height = 16, this.borderRadius = 8});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.darkCard,
      highlightColor: AppTheme.darkBorder,
      child: Container(width: width, height: height, decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(borderRadius))),
    );
  }
}

class DeviceCardShimmer extends StatelessWidget {
  const DeviceCardShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        const ShimmerLoading(width: 48, height: 48, borderRadius: 12),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ShimmerLoading(width: MediaQuery.of(context).size.width * 0.4, height: 14), const SizedBox(height: 8), const ShimmerLoading(width: 100, height: 12)])),
      ]));
  }
}
