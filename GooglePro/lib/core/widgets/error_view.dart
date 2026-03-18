import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback? onRetry;
  final IconData icon;
  const ErrorView({super.key, required this.message, this.title, this.onRetry, this.icon = Icons.error_outline});

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.errorColor.withOpacity(0.1)), child: Icon(icon, color: AppTheme.errorColor, size: 48)).animate().scale(),
      const SizedBox(height: 20),
      if (title != null) Text(title!, style: const TextStyle(color: AppTheme.darkText, fontSize: 20, fontWeight: FontWeight.w700)),
      const SizedBox(height: 8),
      Text(message, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 14, height: 1.5)),
      if (onRetry != null) ...[
        const SizedBox(height: 24),
        ElevatedButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh, color: Colors.black), label: const Text('Try Again', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
      ],
    ])));
  }
}
