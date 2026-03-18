import 'package:flutter/material.dart';
import '../model/capture_config.dart';
import '../../../core/theme/app_theme.dart';

class CaptureSettingsPanel extends StatefulWidget {
  final CaptureConfig config;
  final ValueChanged<CaptureConfig> onChanged;
  const CaptureSettingsPanel({super.key, required this.config, required this.onChanged});
  @override State<CaptureSettingsPanel> createState() => _CaptureSettingsPanelState();
}

class _CaptureSettingsPanelState extends State<CaptureSettingsPanel> {
  late CaptureConfig _cfg;
  @override void initState() { super.initState(); _cfg = widget.config; }

  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(20), decoration: const BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppTheme.darkBorder, borderRadius: BorderRadius.circular(2)))),
        const SizedBox(height: 20),
        const Text('Capture Settings', style: TextStyle(color: AppTheme.darkText, fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 20),
        _label('Frame Rate: ${_cfg.fps} fps'),
        Slider(value: _cfg.fps.toDouble(), min: 5, max: 30, divisions: 5, label: '${_cfg.fps} fps', activeColor: AppTheme.primaryColor,
          onChanged: (v) { setState(() => _cfg = _cfg.copyWith(fps: v.round())); widget.onChanged(_cfg); }),
        _label('Bitrate: ${_cfg.bitrateKbps} kbps'),
        Slider(value: _cfg.bitrateKbps.toDouble(), min: 300, max: 8000, divisions: 15, label: '${_cfg.bitrateKbps}kbps', activeColor: AppTheme.primaryColor,
          onChanged: (v) { setState(() => _cfg = _cfg.copyWith(bitrateKbps: v.round())); widget.onChanged(_cfg); }),
        SwitchListTile(title: const Text('Include Audio', style: TextStyle(color: AppTheme.darkText)), value: _cfg.includeAudio, activeColor: AppTheme.primaryColor,
          onChanged: (v) { setState(() => _cfg = _cfg.copyWith(includeAudio: v)); widget.onChanged(_cfg); }),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          const Text('Resolution: ${1280}×${720}', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 13)),
        ]),
      ]));
  }

  Widget _label(String t) => Padding(padding: const EdgeInsets.only(left: 4, bottom: 4), child: Text(t, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 13)));
}
