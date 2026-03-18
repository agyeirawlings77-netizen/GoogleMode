import 'package:flutter_test/flutter_test.dart';
import 'package:googlepro/features/webrtc/model/signaling_message.dart';

void main() {
  group('SignalingMessage', () {
    test('offer factory creates correct type', () {
      final msg = SignalingMessage.offer('uid_a', 'uid_b', {'sdp': 'test', 'type': 'offer'});
      expect(msg.type, SignalingMessageType.offer);
      expect(msg.from, 'uid_a');
      expect(msg.to, 'uid_b');
    });
    test('toJson/fromJson round trip', () {
      final msg = SignalingMessage.bye('uid_a', 'uid_b');
      final json = msg.toJson();
      final restored = SignalingMessage.fromJson(json);
      expect(restored.type, msg.type);
      expect(restored.from, msg.from);
      expect(restored.to, msg.to);
    });
    test('candidate factory sets payload', () {
      final msg = SignalingMessage.candidate('a', 'b', {'candidate': 'ice_str', 'sdpMid': '0', 'sdpMLineIndex': 0});
      expect(msg.payload?['candidate'], isNotNull);
    });
  });
}
