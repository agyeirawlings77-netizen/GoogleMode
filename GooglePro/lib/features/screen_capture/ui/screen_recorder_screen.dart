import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../model/capture_config.dart';
import '../../../core/theme/app_theme.dart';

class ScreenRecorderScreen extends StatefulWidget {
  final String deviceId;
  const ScreenRecorderScreen({super.key, required this.deviceId});
  @override State<ScreenRecorderScreen> createState() => _ScreenRecorderScreenState();
}

class _ScreenRecorderScreenState extends State<ScreenRecorderScreen> {
  bool _recording = false;
  Duration _elapsed = Duration.zero;
  CaptureConfig _config = CaptureConfig.medium;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Screen Recorder', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 120, height: 120, decoration: BoxDecoration(shape: BoxShape.circle,
          color: _recording ? AppTheme.errorColor.withOpacity(0.15) : AppTheme.primaryColor.withOpacity(0.1),
          border: Border.all(color: _recording ? AppTheme.errorColor.withOpacity(0.4) : AppTheme.primaryColor.withOpacity(0.3), width: 2)),
          child: Icon(_recording ? Icons.stop_rounded : Icons.fiber_manual_record, color: _recording ? AppTheme.errorColor : AppTheme.primaryColor, size: 56))
          .animate(target: _recording ? 1 : 0).scale(begin: const Offset(1,1), end: const Offset(1.05,1.05), duration: 800.ms, curve: Curves.easeInOut),
        const SizedBox(height: 28),
        Text(_recording ? 'Recording...' : 'Ready to Record', style: const TextStyle(color: AppTheme.darkText, fontSize: 20, fontWeight: FontWeight.w700)),
        if (_recording) ...[const SizedBox(height: 8), Text(_fmt(_elapsed), style: const TextStyle(color: AppTheme.errorColor, fontSize: 16, fontWeight: FontWeight.w600))],
        const SizedBox(height: 48),
        SizedBox(width: 200, height: 54, child: ElevatedButton.icon(
          onPressed: () => setState(() => _recording = !_recording),
          icon: Icon(_recording ? Icons.stop : Icons.fiber_manual_record, color: Colors.black),
          label: Text(_recording ? 'Stop Recording' : 'Start Recording', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
          style: ElevatedButton.styleFrom(backgroundColor: _recording ? AppTheme.errorColor : AppTheme.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))))),
      ])),
    );
  }

  String _fmt(Duration d) { final m = d.inMinutes.remainder(60).toString().padLeft(2,'0'); final s = d.inSeconds.remainder(60).toString().padLeft(2,'0'); return '$m:$s'; }
}
