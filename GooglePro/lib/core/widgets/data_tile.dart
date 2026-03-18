import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class DataTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? valueColor;
  const DataTile({super.key, required this.label, required this.value, this.icon, this.valueColor});
  @override Widget build(BuildContext context) => Row(children: [if (icon != null) ...[Icon(icon, color: AppTheme.darkSubtext, size: 16), const SizedBox(width: 8)], Expanded(child: Text(label, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 13))), Text(value, style: TextStyle(color: valueColor ?? AppTheme.darkText, fontSize: 13, fontWeight: FontWeight.w600))]);
}
