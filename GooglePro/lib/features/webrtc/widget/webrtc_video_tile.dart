import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../../core/theme/app_theme.dart';

class WebRtcVideoTile extends StatelessWidget {
  final RTCVideoRenderer renderer;
  final String? label;
  final bool isMirrored;
  final bool showLabel;
  const WebRtcVideoTile({super.key, required this.renderer, this.label, this.isMirrored = false, this.showLabel = true});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: BorderRadius.circular(12),
      child: Stack(children: [
        RTCVideoView(renderer, mirror: isMirrored, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitContain),
        if (showLabel && label != null) Positioned(bottom: 8, left: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(6)), child: Text(label!, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)))),
      ]));
  }
}
