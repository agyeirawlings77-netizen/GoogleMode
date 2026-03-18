import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class AlertBanner extends StatelessWidget {
  final String message;
  final Color color;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionLabel;
  const AlertBanner({super.key, required this.message, this.color = AppTheme.errorColor, this.icon = Icons.warning_amber_rounded, this.onAction, this.actionLabel});
  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.all(16), padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.3))),
      child: Row(children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 10),
        Expanded(child: Text(message, style: TextStyle(color: color, fontSize: 13))),
        if (onAction != null) TextButton(onPressed: onAction, child: Text(actionLabel ?? 'Fix', style: TextStyle(color: color, fontWeight: FontWeight.w600))),
      ]));
  }
}
