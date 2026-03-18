import 'package:flutter/material.dart';
import '../model/security_alert.dart';
import '../../../core/theme/app_theme.dart';
class AlertItem extends StatelessWidget {
  final SecurityAlert alert;
  final VoidCallback onTap;
  const AlertItem({super.key, required this.alert, required this.onTap});
  @override
  Widget build(BuildContext context) {
    Color c;
    switch (alert.severity) {
      case AlertSeverity.critical: c = AppTheme.errorColor; break;
      case AlertSeverity.high: c = Colors.redAccent; break;
      case AlertSeverity.medium: c = Colors.orange; break;
      default: c = AppTheme.primaryColor;
    }
    return ListTile(onTap: onTap, leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: c.withOpacity(0.1), shape: BoxShape.circle), child: Icon(Icons.warning_amber_rounded, color: c, size: 20)), title: Text(alert.description, style: TextStyle(color: alert.isRead ? AppTheme.darkSubtext : AppTheme.darkText, fontSize: 13)), trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(6)), child: Text(alert.severity.name, style: TextStyle(color: c, fontSize: 10, fontWeight: FontWeight.w600))));
  }
}
