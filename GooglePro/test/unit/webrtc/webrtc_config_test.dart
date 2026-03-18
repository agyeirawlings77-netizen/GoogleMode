import 'package:flutter_test/flutter_test.dart';
import 'package:googlepro/features/webrtc/model/webrtc_config.dart';

void main() {
  group('WebRtcConfig', () {
    test('iceServers contains STUN server', () {
      final servers = WebRtcConfig.iceServers['iceServers'] as List;
      expect(servers.any((s) => (s['urls'] as String).startsWith('stun:')), true);
    });
    test('iceServers contains TURN server with credentials', () {
      final servers = WebRtcConfig.iceServers['iceServers'] as List;
      final turn = servers.firstWhere((s) => (s['urls'] as String).startsWith('turn:'), orElse: () => {});
      expect(turn['username'], isNotNull);
      expect(turn['credential'], isNotNull);
    });
    test('sdpConstraints has mandatory fields', () {
      expect(WebRtcConfig.sdpConstraints['mandatory'], isNotNull);
    });
    test('encodingParams returns valid map', () {
      final params = WebRtcConfig.encodingParams(maxBitrate: 1000000, maxFramerate: 20);
      expect(params['maxBitrate'], 1000000);
      expect(params['maxFramerate'], 20);
    });
  });
}
