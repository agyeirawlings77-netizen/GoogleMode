import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class IntruderPhotosScreen extends StatelessWidget {
  const IntruderPhotosScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Intruder Photos', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.camera_front, color: AppTheme.darkSubtext, size: 48),
        SizedBox(height: 12),
        Text('No intruder photos captured', style: TextStyle(color: AppTheme.darkSubtext)),
      ])));
  }
}
