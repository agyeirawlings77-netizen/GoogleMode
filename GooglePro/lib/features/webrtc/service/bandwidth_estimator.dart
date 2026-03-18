import 'package:injectable/injectable.dart';
import '../model/webrtc_state.dart';

@injectable
class BandwidthEstimator {
  int _estimatedKbps = 2000;
  static const _minKbps = 300;
  static const _maxKbps = 8000;

  int get estimatedKbps => _estimatedKbps;

  void updateFromStats(WebRtcStats stats) {
    if (stats.packetLoss > 0.1 || stats.latencyMs > 500) {
      _estimatedKbps = (_estimatedKbps * 0.5).clamp(_minKbps, _maxKbps).round();
    } else if (stats.packetLoss < 0.02 && stats.latencyMs < 100) {
      _estimatedKbps = (_estimatedKbps * 1.1).clamp(_minKbps, _maxKbps).round();
    }
  }

  WebRtcStats adjustQuality(WebRtcStats stats) => WebRtcStats(bitrateKbps: _estimatedKbps.toDouble(), latencyMs: stats.latencyMs, packetLoss: stats.packetLoss, fps: _estimatedKbps > 2000 ? 30 : _estimatedKbps > 1000 ? 20 : 15, resolution: _estimatedKbps > 3000 ? '1280x720' : '640x480', iceState: stats.iceState);
}
