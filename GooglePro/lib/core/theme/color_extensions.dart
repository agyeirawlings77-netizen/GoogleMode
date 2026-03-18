import 'package:flutter/material.dart';
import 'app_theme.dart';

extension ColorExtensions on Color {
  Color get lighter => Color.lerp(this, Colors.white, 0.15)!;
  Color get darker => Color.lerp(this, Colors.black, 0.15)!;
  Color withSaturation(double s) => HSLColor.fromColor(this).withSaturation(s.clamp(0.0, 1.0)).toColor();
}

extension AppThemeExtension on ThemeData {
  bool get isDark => brightness == Brightness.dark;
  Color get primaryDark => isDark ? AppTheme.primaryColor : AppTheme.primaryColor;
  Color get cardColor => isDark ? AppTheme.darkCard : Colors.white;
  Color get bgColor => isDark ? AppTheme.darkBg : Colors.white;
}
