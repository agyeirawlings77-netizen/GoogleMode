import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/content_filter.dart';
import '../../../core/theme/app_theme.dart';
class ContentFilterScreen extends StatefulWidget {
  const ContentFilterScreen({super.key});
  @override State<ContentFilterScreen> createState() => _ContentFilterScreenState();
}
class _ContentFilterScreenState extends State<ContentFilterScreen> {
  ContentFilterLevel _level = ContentFilterLevel.medium;
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Content Filter', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Filter Level', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 13)),
        const SizedBox(height: 12),
        ...ContentFilterLevel.values.map((level) => RadioListTile<ContentFilterLevel>(value: level, groupValue: _level, onChanged: (v) => setState(() => _level = v!), activeColor: AppTheme.primaryColor, title: Text(level.name.toUpperCase(), style: const TextStyle(color: AppTheme.darkText)), tileColor: AppTheme.darkCard, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
      ]));
  }
}
