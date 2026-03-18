import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class StorageSettingsScreen extends StatelessWidget {
  const StorageSettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Storage', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        _storageBar('App Data', 24, Colors.blue),
        _storageBar('Cache', 12, Colors.orange),
        _storageBar('Downloads', 156, Colors.green),
        const SizedBox(height: 24),
        ElevatedButton.icon(onPressed: () {}, icon: const Icon(Icons.cleaning_services, color: Colors.black), label: const Text('Clear Cache', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), minimumSize: const Size(double.infinity, 48))),
      ]));
  }
  Widget _storageBar(String label, int mb, Color color) => Padding(padding: const EdgeInsets.only(bottom: 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [Text(label, style: const TextStyle(color: AppTheme.darkText)), const Spacer(), Text('$mb MB', style: TextStyle(color: color, fontWeight: FontWeight.w600))]),
    const SizedBox(height: 6),
    ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: mb / 200.0, minHeight: 6, backgroundColor: AppTheme.darkBorder, valueColor: AlwaysStoppedAnimation<Color>(color))),
  ]));
}
