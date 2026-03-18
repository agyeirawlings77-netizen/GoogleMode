import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class SessionEndedScreen extends StatelessWidget {
  final String? deviceName;
  final String? duration;
  const SessionEndedScreen({super.key, this.deviceName, this.duration});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      body: SafeArea(child: Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.successColor.withOpacity(0.1)), child: const Icon(Icons.call_end, color: AppTheme.successColor, size: 52)).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
        const SizedBox(height: 24),
        const Text('Session Ended', style: TextStyle(color: AppTheme.darkText, fontSize: 24, fontWeight: FontWeight.w700)),
        if (deviceName != null) ...[const SizedBox(height: 8), Text(deviceName!, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 15))],
        if (duration != null) ...[const SizedBox(height: 4), Text('Duration: $duration', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 13, fontWeight: FontWeight.w600))],
        const SizedBox(height: 40),
        ElevatedButton(onPressed: () => context.go('/dashboard'), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, minimumSize: const Size(200, 52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: const Text('Back to Dashboard', style: TextStyle(fontWeight: FontWeight.w700))),
      ])))));
  }
}
