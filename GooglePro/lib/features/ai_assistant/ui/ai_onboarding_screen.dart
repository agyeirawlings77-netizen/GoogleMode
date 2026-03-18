import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class AiOnboardingScreen extends StatelessWidget {
  const AiOnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(28), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(padding: const EdgeInsets.all(28), decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppTheme.primaryColor, AppTheme.accentColor])), child: const Icon(Icons.auto_awesome, color: Colors.black, size: 56)).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
        const SizedBox(height: 32),
        const Text('Meet GooglePro AI', style: TextStyle(color: AppTheme.darkText, fontSize: 28, fontWeight: FontWeight.w800)).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 12),
        const Text('Powered by Google Gemini, your AI assistant helps you get the most out of GooglePro.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.darkSubtext, fontSize: 15, height: 1.6)).animate().fadeIn(delay: 300.ms),
        const SizedBox(height: 40),
        SizedBox(width: double.infinity, height: 54, child: ElevatedButton(onPressed: () => context.go('/ai-assistant'), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: const Text('Start Chatting', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)))).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3),
      ]))));
  }
}
