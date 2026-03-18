import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: SafeArea(child: Padding(padding: const EdgeInsets.all(28), child: Column(children: [
        const Spacer(),
        Container(width: 120, height: 120, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppTheme.primaryColor, AppTheme.accentColor], begin: Alignment.topLeft, end: Alignment.bottomRight)), child: const Icon(Icons.screen_share_rounded, color: Colors.black, size: 64)).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
        const SizedBox(height: 32),
        const Text('Welcome to\nGooglePro', style: TextStyle(color: AppTheme.darkText, fontSize: 36, fontWeight: FontWeight.w800, height: 1.2), textAlign: TextAlign.center).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 16),
        const Text('Remote screen sharing, monitoring & control — all in one powerful app.', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 16, height: 1.6), textAlign: TextAlign.center).animate().fadeIn(delay: 400.ms),
        const Spacer(),
        SizedBox(width: double.infinity, height: 54, child: ElevatedButton(onPressed: () => context.push('/register'), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Get Started', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)))).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3),
        const SizedBox(height: 12),
        SizedBox(width: double.infinity, height: 54, child: OutlinedButton(onPressed: () => context.push('/login'), style: OutlinedButton.styleFrom(foregroundColor: AppTheme.darkText, side: const BorderSide(color: AppTheme.darkBorder), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)))).animate().fadeIn(delay: 700.ms),
        const SizedBox(height: 16),
      ]))),
    );
  }
}
