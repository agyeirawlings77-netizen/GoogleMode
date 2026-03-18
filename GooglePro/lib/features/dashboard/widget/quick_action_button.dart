import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class QuickActionButton extends StatelessWidget {
  final IconData icon; final String label; final Color color; final VoidCallback onTap;
  const QuickActionButton({super.key, required this.icon, required this.label, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap, child: Column(mainAxisSize: MainAxisSize.min, children: [Container(width: 56, height: 56, decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))), child: Icon(icon, color: color, size: 26)), const SizedBox(height: 6), Text(label, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w500))]));
}
