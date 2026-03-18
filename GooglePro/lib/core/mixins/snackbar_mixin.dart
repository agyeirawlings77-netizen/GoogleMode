import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

mixin SnackBarMixin<T extends StatefulWidget> on State<T> {
  void showSuccess(String message) => _show(message, AppTheme.successColor);
  void showError(String message) => _show(message, AppTheme.errorColor);
  void showInfo(String message) => _show(message, AppTheme.primaryColor);
  void showWarning(String message) => _show(message, AppTheme.warningColor);

  void _show(String message, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)), backgroundColor: color, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), margin: const EdgeInsets.all(12), duration: const Duration(seconds: 3)));
  }
}
