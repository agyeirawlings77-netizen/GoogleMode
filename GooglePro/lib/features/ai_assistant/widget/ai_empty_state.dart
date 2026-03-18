import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
class AiEmptyState extends StatelessWidget {
  final VoidCallback onGetStarted;
  const AiEmptyState({super.key, required this.onGetStarted});
  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(padding: const EdgeInsets.all(24), decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppTheme.primaryColor, AppTheme.accentColor])), child: const Icon(Icons.auto_awesome, color: Colors.black, size: 48)).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
      const SizedBox(height: 24),
      const Text('GooglePro AI', style: TextStyle(color: AppTheme.darkText, fontSize: 22, fontWeight: FontWeight.w700)),
      const SizedBox(height: 8),
      const Text('Ask me anything about screen sharing, device management, or troubleshooting.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.darkSubtext, fontSize: 14, height: 1.6)),
      const SizedBox(height: 32),
      ElevatedButton(onPressed: onGetStarted, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), minimumSize: const Size(160, 48)), child: const Text('Get Started', style: TextStyle(fontWeight: FontWeight.w700))).animate().fadeIn(delay: 300.ms),
    ])));
  }
}
