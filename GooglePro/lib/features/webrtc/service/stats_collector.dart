import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import '../model/webrtc_state.dart';
import '../../../core/utils/app_logger.dart';

@injectable
class StatsCollector {
  Timer? _timer;
  RTCPeerConnection? _pc;
  final _statsCtrl = StreamController<WebRtcStats>.broadcast();

  Stream<WebRtcStats> get statsStream => _statsCtrl.stream;

  void startCollecting(RTCPeerConnection pc) {
    _pc = pc;
    _timer = Timer.periodic(const Duration(seconds: 2), (_) => _collect());
  }

  Future<void> _collect() async {
    if (_pc == null) return;
    try {
      final stats = await _pc!.getStats(null);
      double bitrate = 0; int latency = 0; int fps = 0;
      for (final report in stats) {
        if (report.type == 'inbound-rtp' && report.values.containsKey('bytesReceived')) {
          bitrate = ((report.values['bytesReceived'] as int? ?? 0) * 8 / 1000).toDouble();
        }
        if (report.type == 'candidate-pair' && report.values['state'] == 'succeeded') {
          latency = (report.values['currentRoundTripTime'] as double? ?? 0) ~/ 1 * 1000;
        }
      }
      _statsCtrl.add(WebRtcStats(bitrateKbps: bitrate, latencyMs: latency, fps: fps));
    } catch (e) { AppLogger.warning('Stats collect error: $e'); }
  }

  void stop() { _timer?.cancel(); _timer = null; }
  void dispose() { stop(); _statsCtrl.close(); }
}
