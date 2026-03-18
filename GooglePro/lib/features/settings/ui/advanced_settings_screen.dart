import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widget/settings_section.dart';
import '../widget/settings_tile.dart';
import '../../../core/theme/app_theme.dart';
class AdvancedSettingsScreen extends StatelessWidget {
  const AdvancedSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Advanced', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        SettingsSection(title: 'Developer', children: [
          SettingsTile(icon: Icons.bug_report_outlined, title: 'Debug Logs', onTap: () {}),
          SettingsTile(icon: Icons.network_check, title: 'Network Diagnostics', onTap: () {}),
          SettingsTile(icon: Icons.restart_alt, title: 'Reset All Settings', iconColor: AppTheme.errorColor, onTap: () {}),
        ]),
      ]));
  }
}
