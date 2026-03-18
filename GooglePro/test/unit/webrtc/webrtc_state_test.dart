import 'package:flutter_test/flutter_test.dart';
import 'package:googlepro/features/webrtc/model/webrtc_state.dart';

void main() {
  group('WebRtcStats', () {
    test('excellent quality for low latency', () {
      const stats = WebRtcStats(latencyMs: 50, packetLoss: 0.01);
      expect(stats.qualityLabel, 'Excellent');
      expect(stats.qualityScore, greaterThanOrEqualTo(0.9));
    });
    test('poor quality for high latency', () {
      const stats = WebRtcStats(latencyMs: 600, packetLoss: 0.15);
      expect(stats.qualityLabel, 'Poor');
    });
    test('fair quality for medium latency', () {
      const stats = WebRtcStats(latencyMs: 250, packetLoss: 0.04);
      expect(stats.qualityLabel, 'Fair');
    });
  });
}
