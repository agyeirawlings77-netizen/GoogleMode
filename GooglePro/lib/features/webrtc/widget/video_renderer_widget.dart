import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
class VideoRendererWidget extends StatelessWidget {
  final RTCVideoRenderer renderer;
  final bool mirror;
  final BoxFit fit;
  const VideoRendererWidget({super.key, required this.renderer, this.mirror = false, this.fit = BoxFit.contain});
  @override
  Widget build(BuildContext context) {
    return RTCVideoView(renderer, mirror: mirror, objectFit: fit == BoxFit.cover ? RTCVideoViewObjectFit.RTCVideoViewObjectFitCover : RTCVideoViewObjectFit.RTCVideoViewObjectFitContain);
  }
}
