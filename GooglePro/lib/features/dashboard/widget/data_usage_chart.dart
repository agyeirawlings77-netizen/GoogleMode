import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class DataUsageChart extends StatelessWidget {
  final double totalMb;
  final double usedMb;
  const DataUsageChart({super.key, required this.totalMb, required this.usedMb});
  @override
  Widget build(BuildContext context) {
    final pct = totalMb > 0 ? (usedMb / totalMb).clamp(0.0, 1.0) : 0.0;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text('Data Usage', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 13)),
        Text('${usedMb.toStringAsFixed(1)} MB', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 13, fontWeight: FontWeight.w600)),
      ]),
      const SizedBox(height: 8),
      ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: pct, minHeight: 6, backgroundColor: AppTheme.darkBorder, valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor))),
    ]);
  }
}
