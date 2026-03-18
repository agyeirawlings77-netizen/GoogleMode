import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('About', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        Center(child: Column(children: [
          Container(width: 80, height: 80, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppTheme.primaryColor, AppTheme.accentColor])), child: const Icon(Icons.screen_share_rounded, color: Colors.black, size: 40)),
          const SizedBox(height: 16),
          const Text('GooglePro', style: TextStyle(color: AppTheme.darkText, fontSize: 26, fontWeight: FontWeight.w800)),
          const Text('Version 1.0.0 (build 1)', style: TextStyle(color: AppTheme.darkSubtext)),
        ])),
        const SizedBox(height: 32),
        _row('Developer', 'Rawlings'),
        _row('Platform', 'Android 5.0+'),
        _row('Framework', 'Flutter 3.22'),
        _row('Backend', 'Firebase'),
        _row('Video', 'WebRTC P2P'),
        _row('AI', 'Google Gemini'),
      ]));
  }
  Widget _row(String l, String v) => Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(children: [Text(l, style: const TextStyle(color: AppTheme.darkSubtext)), const Spacer(), Text(v, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w500))]));
}
