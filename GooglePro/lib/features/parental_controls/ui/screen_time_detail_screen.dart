import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widget/screen_time_ring.dart';
import '../../../core/theme/app_theme.dart';
class ScreenTimeDetailScreen extends StatelessWidget {
  const ScreenTimeDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Screen Time', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Center(child: ScreenTimeRing(usedMinutes: 95, limitMinutes: 120)),
        const SizedBox(height: 24),
        const Text('Today\'s Usage', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1)),
      ]));
  }
}
