class ConnectionStats {
  final double bitrateKbps;
  final double packetLoss;
  final int roundTripMs;
  final String codec;
  final int width;
  final int height;
  final double fps;
  const ConnectionStats({this.bitrateKbps = 0, this.packetLoss = 0, this.roundTripMs = 0, this.codec = '', this.width = 0, this.height = 0, this.fps = 0});
  String get resolution => width > 0 ? '${width}x$height' : 'N/A';
  String get quality { if (packetLoss < 1 && roundTripMs < 80) return 'Excellent'; if (packetLoss < 3 && roundTripMs < 150) return 'Good'; if (packetLoss < 8 && roundTripMs < 300) return 'Fair'; return 'Poor'; }
}
