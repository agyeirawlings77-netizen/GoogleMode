import 'package:flutter_webrtc/flutter_webrtc.dart';
class RtcSession {
  final String sessionId;
  final String localUserId;
  final String remoteUserId;
  final RTCPeerConnection peerConnection;
  RTCVideoRenderer? localRenderer;
  RTCVideoRenderer? remoteRenderer;
  MediaStream? localStream;
  MediaStream? remoteStream;
  bool isHost;
  bool isScreenSharing;
  DateTime startedAt;
  RtcSession({required this.sessionId, required this.localUserId, required this.remoteUserId, required this.peerConnection, this.localRenderer, this.remoteRenderer, this.localStream, this.remoteStream, this.isHost = false, this.isScreenSharing = false, required this.startedAt});
  Duration get duration => DateTime.now().difference(startedAt);
}
