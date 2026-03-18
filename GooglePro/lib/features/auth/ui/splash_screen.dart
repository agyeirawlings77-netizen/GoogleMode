import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 1800));
    if (!mounted) return;
    final prefs = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool('onboarding_done') ?? false;
    if (!onboardingDone) { context.go('/welcome'); return; }
    final user = FirebaseAuth.instance.currentUser;
    context.go(user != null ? '/dashboard' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 100, height: 100, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppTheme.primaryColor, AppTheme.accentColor], begin: Alignment.topLeft, end: Alignment.bottomRight)), child: const Icon(Icons.screen_share_rounded, color: Colors.black, size: 52)).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
        const SizedBox(height: 20),
        const Text('GooglePro', style: TextStyle(color: AppTheme.darkText, fontSize: 32, fontWeight: FontWeight.w800)).animate().fadeIn(delay: 400.ms),
        const Text('Remote Screen Share & Control', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 13)).animate().fadeIn(delay: 600.ms),
        const SizedBox(height: 60),
        const SizedBox(width: 28, height: 28, child: CircularProgressIndicator(color: AppTheme.primaryColor, strokeWidth: 2.5)).animate().fadeIn(delay: 800.ms),
      ])),
    );
  }
}
