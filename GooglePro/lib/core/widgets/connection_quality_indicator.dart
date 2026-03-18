import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class ConnectionQualityIndicator extends StatelessWidget {
  final double quality; // 0.0 - 1.0
  const ConnectionQualityIndicator({super.key, required this.quality});
  @override
  Widget build(BuildContext context) {
    final color = quality > 0.7 ? AppTheme.successColor : quality > 0.4 ? AppTheme.warningColor : AppTheme.errorColor;
    return Row(mainAxisSize: MainAxisSize.min, children: List.generate(4, (i) {
      final active = quality >= (i + 1) * 0.25;
      return Container(width: 4, height: 8.0 + i * 4, margin: const EdgeInsets.only(right: 2), decoration: BoxDecoration(color: active ? color : AppTheme.darkBorder, borderRadius: BorderRadius.circular(2)));
    }));
  }
}
