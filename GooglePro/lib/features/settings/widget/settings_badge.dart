import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class SettingsBadge extends StatelessWidget {
  final String label;
  final Color? color;
  const SettingsBadge({super.key, required this.label, this.color});
  @override
  Widget build(BuildContext context) {
    final c = color ?? AppTheme.primaryColor;
    return Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: c.withOpacity(0.3))), child: Text(label, style: TextStyle(color: c, fontSize: 11, fontWeight: FontWeight.w600)));
  }
}
