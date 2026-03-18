import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class BatteryIndicator extends StatelessWidget {
  final int level;
  final bool isCharging;
  const BatteryIndicator({super.key, required this.level, this.isCharging = false});
  @override
  Widget build(BuildContext context) {
    final color = level <= 20 ? AppTheme.errorColor : level <= 50 ? AppTheme.warningColor : AppTheme.successColor;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Stack(alignment: Alignment.center, children: [
        Icon(level <= 20 ? Icons.battery_alert : Icons.battery_std, color: color, size: 18),
        if (isCharging) const Icon(Icons.bolt, color: Colors.yellow, size: 10),
      ]),
      const SizedBox(width: 4),
      Text('$level%', style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    ]);
  }
}
