import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class SettingsGroupHeader extends StatelessWidget {
  final String title;
  const SettingsGroupHeader({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(left: 4, top: 20, bottom: 8), child: Text(title.toUpperCase(), style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)));
  }
}
