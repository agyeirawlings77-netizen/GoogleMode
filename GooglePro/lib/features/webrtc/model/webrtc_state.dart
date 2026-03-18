enum WebRtcConnectionState { idle, initializing, connecting, connected, reconnecting, failed, closed }
enum IceConnectionState { idle, checking, connected, failed, disconnected, closed }

class WebRtcStats {
  final double bitrateKbps;
  final int latencyMs;
  final double packetLoss;
  final int fps;
  final String resolution;
  final IceConnectionState iceState;
  const WebRtcStats({this.bitrateKbps = 0, this.latencyMs = 0, this.packetLoss = 0, this.fps = 0, this.resolution = '0x0', this.iceState = IceConnectionState.idle});
  double get qualityScore { if (latencyMs > 500 || packetLoss > 0.1) return 0.2; if (latencyMs > 200 || packetLoss > 0.05) return 0.5; if (latencyMs > 100) return 0.75; return 1.0; }
  String get qualityLabel { final s = qualityScore; if (s >= 0.9) return 'Excellent'; if (s >= 0.7) return 'Good'; if (s >= 0.5) return 'Fair'; return 'Poor'; }
}
