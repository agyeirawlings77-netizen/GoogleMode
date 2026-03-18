import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class CallEndedScreen extends StatelessWidget {
  final String deviceName;
  final Duration duration;
  const CallEndedScreen({super.key, required this.deviceName, required this.duration});
  @override
  Widget build(BuildContext context) {
    final m = duration.inMinutes.toString().padLeft(2,'0');
    final s = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
    return Scaffold(backgroundColor: AppTheme.darkBg,
      body: Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.errorColor.withOpacity(0.1)), child: const Icon(Icons.call_end, color: AppTheme.errorColor, size: 48)).animate().scale(),
        const SizedBox(height: 24),
        const Text('Call Ended', style: TextStyle(color: AppTheme.darkText, fontSize: 24, fontWeight: FontWeight.w700)).animate().fadeIn(),
        const SizedBox(height: 8),
        Text(deviceName, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 16)),
        const SizedBox(height: 4),
        Text('Duration: $m:$s', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 16, fontWeight: FontWeight.w500)).animate().fadeIn(delay: 100.ms),
        const SizedBox(height: 40),
        SizedBox(width: double.infinity, height: 52, child: ElevatedButton(onPressed: () => context.go('/dashboard'),
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          child: const Text('Back to Home', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)))).animate().fadeIn(delay: 200.ms),
      ]))));
  }
}
