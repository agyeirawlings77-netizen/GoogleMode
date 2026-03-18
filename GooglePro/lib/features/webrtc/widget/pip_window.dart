import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../../core/theme/app_theme.dart';
class PipWindow extends StatelessWidget {
  final RTCVideoRenderer renderer;
  final VoidCallback? onTap;
  const PipWindow({super.key, required this.renderer, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Positioned(right: 16, bottom: 80,
      child: GestureDetector(onTap: onTap,
        child: Container(width: 120, height: 180, decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.primaryColor.withOpacity(0.5)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)]),
          child: ClipRRect(borderRadius: BorderRadius.circular(12), child: RTCVideoView(renderer, mirror: true)))));
  }
}
