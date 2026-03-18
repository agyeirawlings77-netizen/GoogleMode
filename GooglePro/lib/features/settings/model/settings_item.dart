import 'package:flutter/material.dart';
enum SettingsItemType { toggle, navigation, info, button, slider }
class SettingsItem {
  final String id;
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final SettingsItemType type;
  final bool? value;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onToggle;
  const SettingsItem({required this.id, required this.title, this.subtitle, required this.icon, this.iconColor, this.type = SettingsItemType.navigation, this.value, this.onTap, this.onToggle});
}
