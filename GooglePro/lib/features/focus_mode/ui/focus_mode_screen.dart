import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
class FocusModeScreen extends StatefulWidget {
  final String deviceId;
  const FocusModeScreen({super.key, required this.deviceId});
  @override State<FocusModeScreen> createState() => _FocusModeScreenState();
}
class _FocusModeScreenState extends State<FocusModeScreen> {
  int _durationMinutes = 25;
  bool _blockAll = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Focus Mode', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: Padding(padding: const EdgeInsets.all(24), child: Column(children: [
        const Icon(Icons.center_focus_strong, color: Colors.orange, size: 72),
        const SizedBox(height: 20),
        Text('$_durationMinutes min focus session', style: const TextStyle(color: AppTheme.darkText, fontSize: 22, fontWeight: FontWeight.w700)),
        const SizedBox(height: 16),
        Slider(value: _durationMinutes.toDouble(), min: 5, max: 120, divisions: 23, onChanged: (v) => setState(() => _durationMinutes = v.round()), activeColor: Colors.orange, inactiveColor: AppTheme.darkBorder),
        SwitchListTile(title: const Text('Block all apps', style: TextStyle(color: AppTheme.darkText)), value: _blockAll, onChanged: (v) => setState(() => _blockAll = v), activeColor: Colors.orange, tileColor: AppTheme.darkCard, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        const Spacer(),
        SizedBox(width: double.infinity, height: 52, child: ElevatedButton(onPressed: () => context.pop(), style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: const Text('Start Focus Session', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)))),
      ])));
  }
}
