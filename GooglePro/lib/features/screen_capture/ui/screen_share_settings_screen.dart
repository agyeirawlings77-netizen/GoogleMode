import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../model/capture_config.dart';
import '../../../core/theme/app_theme.dart';

class ScreenShareSettingsScreen extends StatefulWidget {
  final CaptureConfig initialConfig;
  final ValueChanged<CaptureConfig> onConfigChanged;
  const ScreenShareSettingsScreen({super.key, required this.initialConfig, required this.onConfigChanged});
  @override State<ScreenShareSettingsScreen> createState() => _ScreenShareSettingsScreenState();
}

class _ScreenShareSettingsScreenState extends State<ScreenShareSettingsScreen> {
  late CaptureConfig _config;
  @override void initState() { super.initState(); _config = widget.initialConfig; }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Share Settings', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        _sectionLabel('Quality Preset'),
        const SizedBox(height: 8),
        ...CaptureQuality.values.map((q) {
          final preset = q == CaptureQuality.low ? CaptureConfig.low : q == CaptureQuality.high ? CaptureConfig.high : CaptureConfig.medium;
          return RadioListTile<CaptureQuality>(
            title: Text(q.label, style: const TextStyle(color: AppTheme.darkText)),
            subtitle: Text('${preset.fps} FPS • ${preset.bitrateKbps} kbps', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
            value: q, groupValue: _config.quality, activeColor: AppTheme.primaryColor,
            onChanged: (v) { if (v != null) setState(() { _config = preset; widget.onConfigChanged(_config); }); });
        }),
        const SizedBox(height: 20),
        _sectionLabel('Frame Rate'),
        Slider(value: _config.fps.toDouble(), min: 5, max: 30, divisions: 5, activeColor: AppTheme.primaryColor, inactiveColor: AppTheme.darkBorder,
          label: '${_config.fps} FPS', onChanged: (v) => setState(() { _config = _config.copyWith(fps: v.round()); widget.onConfigChanged(_config); })),
        const SizedBox(height: 16),
        _sectionLabel('Bitrate'),
        Slider(value: _config.bitrateKbps.toDouble(), min: 500, max: 8000, divisions: 15, activeColor: AppTheme.primaryColor, inactiveColor: AppTheme.darkBorder,
          label: '${_config.bitrateKbps} kbps', onChanged: (v) => setState(() { _config = _config.copyWith(bitrateKbps: v.round()); widget.onConfigChanged(_config); })),
        const SizedBox(height: 16),
        SwitchListTile(title: const Text('Capture Audio', style: TextStyle(color: AppTheme.darkText)), subtitle: const Text('Include device audio in stream', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
          value: _config.captureAudio, activeColor: AppTheme.primaryColor,
          onChanged: (v) => setState(() { _config = _config.copyWith(captureAudio: v); widget.onConfigChanged(_config); })),
      ]),
    );
  }

  Widget _sectionLabel(String t) => Text(t, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1));
}
