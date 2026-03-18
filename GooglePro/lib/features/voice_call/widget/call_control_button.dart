import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class CallControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final Color? activeColor;
  final VoidCallback onTap;
  const CallControlButton({super.key, required this.icon, required this.label, required this.active, this.activeColor, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final c = activeColor ?? (active ? AppTheme.primaryColor : AppTheme.darkSubtext);
    return GestureDetector(onTap: onTap, child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 56, height: 56, decoration: BoxDecoration(shape: BoxShape.circle, color: c.withOpacity(0.15), border: Border.all(color: c.withOpacity(0.3))), child: Icon(icon, color: c, size: 24)),
      const SizedBox(height: 6),
      Text(label, style: TextStyle(color: c.withOpacity(0.8), fontSize: 11)),
    ]));
  }
}
