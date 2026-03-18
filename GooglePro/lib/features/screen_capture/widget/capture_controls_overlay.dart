import 'package:flutter/material.dart';
import '../state/capture_state.dart';
import '../../../core/theme/app_theme.dart';

class CaptureControlsOverlay extends StatelessWidget {
  final CaptureState state;
  final bool visible;
  final VoidCallback onStop;
  final VoidCallback onToggleAudio;
  const CaptureControlsOverlay({super.key, required this.state, required this.visible, required this.onStop, required this.onToggleAudio});

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();
    final stats = state is CaptureActive ? state as CaptureActive : null;
    return SafeArea(child: Column(children: [
      Align(alignment: Alignment.topLeft, child: Container(margin: const EdgeInsets.all(12), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(8)), child: Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 8, height: 8, margin: const EdgeInsets.only(right: 6), decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red)), const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w800)), if (stats != null) Text('  ${stats.fps}fps  ${stats.bitrateKbps.toStringAsFixed(0)}kbps', style: const TextStyle(color: Colors.white70, fontSize: 10))]))),
      const Spacer(),
      Container(margin: const EdgeInsets.all(16), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(32)), child: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: const Icon(Icons.mic_outlined, color: Colors.white), onPressed: onToggleAudio), const SizedBox(width: 8), ElevatedButton(onPressed: onStop, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorColor, foregroundColor: Colors.white, shape: const CircleBorder(), padding: const EdgeInsets.all(12)), child: const Icon(Icons.stop_rounded, size: 24))])),
    ]));
  }
}
