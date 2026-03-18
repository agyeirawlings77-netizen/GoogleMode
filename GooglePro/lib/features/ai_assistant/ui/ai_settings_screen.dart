import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class AiSettingsScreen extends StatelessWidget {
  const AiSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('AI Settings', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        ListTile(tileColor: AppTheme.darkCard, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), leading: const Icon(Icons.auto_awesome, color: AppTheme.primaryColor), title: const Text('Gemini AI', style: TextStyle(color: AppTheme.darkText)), trailing: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: AppTheme.successColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: const Text('Connected', style: TextStyle(color: AppTheme.successColor, fontSize: 11, fontWeight: FontWeight.w600)))),
        const SizedBox(height: 10),
        ListTile(tileColor: AppTheme.darkCard, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), leading: const Icon(Icons.delete_outline, color: AppTheme.errorColor), title: const Text('Clear Chat History', style: TextStyle(color: AppTheme.errorColor)), onTap: () {}),
      ]));
  }
}
