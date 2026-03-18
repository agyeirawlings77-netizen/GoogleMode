import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class AppBlockingScreen extends StatelessWidget {
  const AppBlockingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Block Apps', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView.builder(padding: const EdgeInsets.all(16), itemCount: 10, itemBuilder: (ctx, i) {
        return ListTile(leading: Container(width: 40, height: 40, decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.apps, color: AppTheme.primaryColor, size: 22)),
          title: Text('App ${i + 1}', style: const TextStyle(color: AppTheme.darkText)), trailing: Switch(value: i % 3 == 0, onChanged: (v) {}, activeColor: AppTheme.errorColor));
      }));
  }
}
