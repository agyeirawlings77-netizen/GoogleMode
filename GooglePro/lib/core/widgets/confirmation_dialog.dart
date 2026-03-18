import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final Color confirmColor;
  final VoidCallback onConfirm;
  const ConfirmationDialog({super.key, required this.title, required this.message, this.confirmLabel = 'Confirm', this.cancelLabel = 'Cancel', this.confirmColor = AppTheme.primaryColor, required this.onConfirm});

  static Future<bool?> show(BuildContext context, {required String title, required String message, String confirmLabel = 'Confirm', Color confirmColor = AppTheme.errorColor}) =>
    showDialog<bool>(context: context, builder: (_) => ConfirmationDialog(title: title, message: message, confirmLabel: confirmLabel, confirmColor: confirmColor, onConfirm: () => Navigator.pop(context, true)));

  @override
  Widget build(BuildContext context) {
    return AlertDialog(backgroundColor: AppTheme.darkCard, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(title, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)),
      content: Text(message, style: const TextStyle(color: AppTheme.darkSubtext, height: 1.5)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: Text(cancelLabel, style: const TextStyle(color: AppTheme.darkSubtext))),
        ElevatedButton(onPressed: () { Navigator.pop(context, true); onConfirm(); }, style: ElevatedButton.styleFrom(backgroundColor: confirmColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: Text(confirmLabel, style: const TextStyle(fontWeight: FontWeight.w700))),
      ]);
  }
}
