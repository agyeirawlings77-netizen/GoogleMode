import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class PatternLockScreen extends StatelessWidget {
  const PatternLockScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Draw Pattern', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: const Center(child: Text('Pattern lock UI', style: TextStyle(color: AppTheme.darkSubtext))));
  }
}
