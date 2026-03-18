import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppTextStyles {
  static const headline1 = TextStyle(color: AppTheme.darkText, fontSize: 28, fontWeight: FontWeight.w800, height: 1.2);
  static const headline2 = TextStyle(color: AppTheme.darkText, fontSize: 22, fontWeight: FontWeight.w700, height: 1.3);
  static const headline3 = TextStyle(color: AppTheme.darkText, fontSize: 18, fontWeight: FontWeight.w700, height: 1.4);
  static const body1 = TextStyle(color: AppTheme.darkText, fontSize: 15, height: 1.6);
  static const body2 = TextStyle(color: AppTheme.darkText, fontSize: 13, height: 1.5);
  static const caption = TextStyle(color: AppTheme.darkSubtext, fontSize: 11, letterSpacing: 0.5);
  static const label = TextStyle(color: AppTheme.darkSubtext, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.8);
  static const button = TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700);
  static const primaryLabel = TextStyle(color: AppTheme.primaryColor, fontSize: 13, fontWeight: FontWeight.w600);
  static const errorText = TextStyle(color: AppTheme.errorColor, fontSize: 12);
  static const successText = TextStyle(color: AppTheme.successColor, fontSize: 12, fontWeight: FontWeight.w600);
}
