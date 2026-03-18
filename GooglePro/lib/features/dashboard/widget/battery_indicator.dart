import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class BatteryIndicator extends StatelessWidget {
  final int level;
  final bool isCharging;
  const BatteryIndicator({super.key, required this.level, this.isCharging = false});
  @override
  Widget build(BuildContext context) {
    final color = level > 50 ? AppTheme.successColor : level > 20 ? Colors.orange : AppTheme.errorColor;
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(isCharging ? Icons.battery_charging_full : _batteryIcon(level), color: color, size: 18),
      const SizedBox(width: 4),
      Text('$level%', style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    ]);
  }
  IconData _batteryIcon(int l) { if (l > 80) return Icons.battery_full; if (l > 60) return Icons.battery_5_bar; if (l > 40) return Icons.battery_4_bar; if (l > 20) return Icons.battery_2_bar; return Icons.battery_1_bar; }
}
