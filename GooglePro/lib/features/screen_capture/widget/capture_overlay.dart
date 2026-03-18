import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
class CaptureOverlay extends StatelessWidget {
  final bool visible;
  final VoidCallback onStop;
  final VoidCallback onPause;
  final bool isPaused;
  final int fps;
  const CaptureOverlay({super.key, required this.visible, required this.onStop, required this.onPause, this.isPaused = false, this.fps = 0});
  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();
    return Positioned(top: 0, left: 0, right: 0, child: SafeArea(child: Container(margin: const EdgeInsets.all(12), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.8), borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: isPaused ? Colors.orange : AppTheme.errorColor,
          boxShadow: isPaused ? null : [BoxShadow(color: AppTheme.errorColor.withOpacity(0.6), blurRadius: 6, spreadRadius: 2)]))
          .animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(begin: 0.8, end: 1.2, duration: 800.ms),
        const SizedBox(width: 8),
        Text(isPaused ? 'PAUSED' : 'LIVE • ${fps}fps', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
        const Spacer(),
        GestureDetector(onTap: onPause, child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(6)), child: Icon(isPaused ? Icons.play_arrow : Icons.pause, color: Colors.white, size: 16))),
        const SizedBox(width: 8),
        GestureDetector(onTap: onStop, child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: AppTheme.errorColor.withOpacity(0.2), borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.stop, color: AppTheme.errorColor, size: 16))),
      ])));
  }
}
