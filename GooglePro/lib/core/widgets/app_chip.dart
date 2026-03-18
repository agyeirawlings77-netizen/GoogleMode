import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppChip extends StatelessWidget {
  final String label;
  final Color? color;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool selected;
  const AppChip({super.key, required this.label, this.color, this.icon, this.onTap, this.selected = false});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppTheme.primaryColor;
    return GestureDetector(onTap: onTap, child: AnimatedContainer(duration: const Duration(milliseconds: 200), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: selected ? c.withOpacity(0.15) : AppTheme.darkCard, borderRadius: BorderRadius.circular(20), border: Border.all(color: selected ? c.withOpacity(0.5) : AppTheme.darkBorder)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[Icon(icon, color: selected ? c : AppTheme.darkSubtext, size: 14), const SizedBox(width: 4)],
        Text(label, style: TextStyle(color: selected ? c : AppTheme.darkSubtext, fontSize: 12, fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
      ])));
  }
}
