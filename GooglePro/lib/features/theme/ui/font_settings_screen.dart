import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class FontSettingsScreen extends StatelessWidget {
  const FontSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Font', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Font Size', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 13)),
        const SizedBox(height: 8),
        ...['Small', 'Medium', 'Large', 'Extra Large'].asMap().entries.map((e) => RadioListTile<int>(value: e.key, groupValue: 1, onChanged: (v) {}, activeColor: AppTheme.primaryColor, tileColor: AppTheme.darkCard, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), title: Text(e.value, style: const TextStyle(color: AppTheme.darkText)))),
      ]));
  }
}
