import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  const SettingsTile({super.key, required this.icon, this.iconColor = AppTheme.primaryColor, required this.title, this.subtitle, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      onTap: onTap,
      leading: Container(width: 34, height: 34, decoration: BoxDecoration(color: iconColor.withOpacity(0.12), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: iconColor, size: 18)),
      title: Text(title, style: const TextStyle(color: AppTheme.darkText, fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle!, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 12)) : null,
      trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right, color: AppTheme.darkSubtext, size: 18) : null),
    );
  }
}
