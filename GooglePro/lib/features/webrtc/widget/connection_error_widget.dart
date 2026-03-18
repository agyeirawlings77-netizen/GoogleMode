import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ConnectionErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const ConnectionErrorWidget({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.errorColor.withOpacity(0.1)),
        child: const Icon(Icons.signal_wifi_off, color: AppTheme.errorColor, size: 48)),
      const SizedBox(height: 20),
      const Text('Connection Failed', style: TextStyle(color: AppTheme.darkText, fontSize: 20, fontWeight: FontWeight.w700)),
      const SizedBox(height: 8),
      Text(message, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 14)),
      const SizedBox(height: 28),
      ElevatedButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh, color: Colors.black), label: const Text('Retry', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
        style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
    ])));
  }
}
