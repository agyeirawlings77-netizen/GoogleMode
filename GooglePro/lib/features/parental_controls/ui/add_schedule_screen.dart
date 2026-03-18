import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class AddScheduleScreen extends StatelessWidget {
  const AddScheduleScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Add Schedule', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop()),
        actions: [TextButton(onPressed: () => context.pop(), child: const Text('Save', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w700)))]),
      body: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Schedule Name', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 13)),
        const SizedBox(height: 8),
        TextField(decoration: InputDecoration(hintText: 'e.g. Bedtime', hintStyle: const TextStyle(color: AppTheme.darkSubtext), filled: true, fillColor: AppTheme.darkCard, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder))), style: const TextStyle(color: AppTheme.darkText)),
      ])));
  }
}
