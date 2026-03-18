import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  const InfoCard({super.key, required this.icon, required this.title, required this.value, this.color = AppTheme.primaryColor});
  @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle), child: Icon(icon, color: color, size: 20)), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)), Text(value, style: const TextStyle(color: AppTheme.darkText, fontSize: 16, fontWeight: FontWeight.w700))]))
    ]));
}
