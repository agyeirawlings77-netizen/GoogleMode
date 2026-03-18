import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_theme.dart';

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  const OnboardingPage({required this.title, required this.description, required this.icon, required this.color});
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  static const _pages = [
    OnboardingPage(title: 'Remote Screen Share', description: 'View and control any device\'s screen in real time using secure WebRTC P2P technology.', icon: Icons.screen_share_rounded, color: AppTheme.primaryColor),
    OnboardingPage(title: 'Auto-Connect Trusted Devices', description: 'Pair devices once and they reconnect automatically — even after reboot or force close.', icon: Icons.link_rounded, color: AppTheme.accentColor),
    OnboardingPage(title: 'Parental Controls', description: 'Monitor screen time, block apps, and set schedules to keep children safe.', icon: Icons.child_care_rounded, color: Color(0xFFFF6D00)),
    OnboardingPage(title: 'AI-Powered Assistant', description: 'Ask GooglePro AI anything — powered by Google Gemini to help you navigate features.', icon: Icons.auto_awesome_rounded, color: Color(0xFF7C4DFF)),
  ];

  @override void dispose() { _controller.dispose(); super.dispose(); }

  Future<void> _complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: SafeArea(child: Column(children: [
        Expanded(child: PageView.builder(controller: _controller, onPageChanged: (i) => setState(() => _currentPage = i), itemCount: _pages.length, itemBuilder: (ctx, i) {
          final p = _pages[i];
          return Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(width: 120, height: 120, decoration: BoxDecoration(shape: BoxShape.circle, color: p.color.withOpacity(0.15), border: Border.all(color: p.color.withOpacity(0.3), width: 2)),
              child: Icon(p.icon, color: p.color, size: 60)).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
            const SizedBox(height: 40),
            Text(p.title, style: const TextStyle(color: AppTheme.darkText, fontSize: 28, fontWeight: FontWeight.w800), textAlign: TextAlign.center).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 16),
            Text(p.description, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 16, height: 1.6), textAlign: TextAlign.center).animate().fadeIn(delay: 300.ms),
          ]));
        })),

        // Dots
        Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(_pages.length, (i) =>
          AnimatedContainer(duration: const Duration(milliseconds: 300), width: _currentPage == i ? 24 : 8, height: 8, margin: const EdgeInsets.symmetric(horizontal: 3), decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: _currentPage == i ? AppTheme.primaryColor : AppTheme.darkBorder)))),

        const SizedBox(height: 24),

        Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Row(children: [
          if (_currentPage > 0) Expanded(child: OutlinedButton(onPressed: () => _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut), style: OutlinedButton.styleFrom(minimumSize: const Size(0, 52), side: const BorderSide(color: AppTheme.darkBorder), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: const Text('Back', style: TextStyle(color: AppTheme.darkText))))
          else Expanded(child: TextButton(onPressed: _complete, child: const Text('Skip', style: TextStyle(color: AppTheme.darkSubtext)))),
          const SizedBox(width: 12),
          Expanded(flex: 2, child: ElevatedButton(onPressed: _currentPage == _pages.length - 1 ? _complete : () => _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, minimumSize: const Size(0, 52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
            child: Text(_currentPage == _pages.length - 1 ? "Get Started" : "Next", style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)))),
        ])),
        const SizedBox(height: 16),
      ])),
    );
  }
}
