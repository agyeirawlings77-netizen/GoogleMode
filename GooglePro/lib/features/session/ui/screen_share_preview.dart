import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../../core/theme/app_theme.dart';
class ScreenSharePreview extends StatelessWidget {
  final RTCVideoRenderer renderer;
  final bool isSharing;
  const ScreenSharePreview({super.key, required this.renderer, required this.isSharing});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 16 / 9,
      child: Container(decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12), border: Border.all(color: isSharing ? AppTheme.primaryColor.withOpacity(0.4) : AppTheme.darkBorder)),
        child: isSharing ? ClipRRect(borderRadius: BorderRadius.circular(12), child: RTCVideoView(renderer))
          : Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.screen_share_outlined, color: AppTheme.darkSubtext, size: 40), const SizedBox(height: 8), const Text('Not sharing', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 13))]))));
  }
}
