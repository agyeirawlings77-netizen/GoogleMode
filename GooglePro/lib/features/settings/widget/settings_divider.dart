import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});
  @override Widget build(BuildContext context) => const Divider(height: 1, color: AppTheme.darkBorder, indent: 52);
}
