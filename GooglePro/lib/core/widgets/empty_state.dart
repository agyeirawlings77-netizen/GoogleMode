import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final Widget? action;
  const EmptyState({super.key, required this.title, this.subtitle, this.icon = Icons.inbox_outlined, this.iconColor = AppTheme.primaryColor, this.action});

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(shape: BoxShape.circle, color: iconColor.withOpacity(0.1)), child: Icon(icon, color: iconColor, size: 52)).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
      const SizedBox(height: 20),
      Text(title, style: const TextStyle(color: AppTheme.darkText, fontSize: 18, fontWeight: FontWeight.w700), textAlign: TextAlign.center).animate().fadeIn(delay: 200.ms),
      if (subtitle != null) ...[
        const SizedBox(height: 8),
        Text(subtitle!, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 14, height: 1.5), textAlign: TextAlign.center).animate().fadeIn(delay: 300.ms),
      ],
      if (action != null) ...[const SizedBox(height: 24), action!.animate().fadeIn(delay: 400.ms)],
    ])));
  }
}
