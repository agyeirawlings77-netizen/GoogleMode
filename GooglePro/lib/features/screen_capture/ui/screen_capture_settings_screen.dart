import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/capture_config.dart';
import '../../../core/theme/app_theme.dart';

class ScreenCaptureSettingsScreen extends StatefulWidget {
  const ScreenCaptureSettingsScreen({super.key});
  @override State<ScreenCaptureSettingsScreen> createState() => _ScreenCaptureSettingsScreenState();
}

class _ScreenCaptureSettingsScreenState extends State<ScreenCaptureSettingsScreen> {
  CaptureConfig _config = const CaptureConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Capture Settings', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('QUALITY', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
        const SizedBox(height: 10),
        ...[('Low', CaptureConfig.low), ('Normal', const CaptureConfig()), ('High', CaptureConfig.high)].map((q) {
          final isSelected = _config.fps == q.$2.fps;
          return Container(margin: const EdgeInsets.only(bottom: 8), child: RadioListTile<CaptureConfig>(value: q.$2, groupValue: _config, onChanged: (v) { if (v != null) setState(() => _config = v); }, title: Text(q.$1, style: const TextStyle(color: AppTheme.darkText)), subtitle: Text('${q.$2.fps}fps · ${q.$2.bitrateKbps}kbps · ${q.$2.width}x${q.$2.height}', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)), activeColor: AppTheme.primaryColor, tileColor: isSelected ? AppTheme.primaryColor.withOpacity(0.05) : AppTheme.darkCard, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));
        }),
        const SizedBox(height: 20),
        SwitchListTile(title: const Text('Include Audio', style: TextStyle(color: AppTheme.darkText)), value: _config.audioEnabled, onChanged: (v) => setState(() => _config = _config.copyWith(audioEnabled: v)), activeColor: AppTheme.primaryColor, tileColor: AppTheme.darkCard, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ]));
  }
}
