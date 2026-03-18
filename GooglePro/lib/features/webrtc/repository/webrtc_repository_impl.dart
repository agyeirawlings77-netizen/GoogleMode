import 'package:injectable/injectable.dart';
import '../signaling/signaling_repository.dart';
import '../model/signaling_message.dart';
import 'webrtc_repository.dart';

@LazySingleton(as: WebRtcRepository)
class WebRtcRepositoryImpl implements WebRtcRepository {
  final SignalingRepository _signaling;
  WebRtcRepositoryImpl(this._signaling);
  @override Future<void> sendOffer(String f, String t, Map<String, dynamic> s) => _signaling.sendOffer(f, t, s);
  @override Future<void> sendAnswer(String f, String t, Map<String, dynamic> s) => _signaling.sendAnswer(f, t, s);
  @override Future<void> sendCandidate(String f, String t, Map<String, dynamic> c) => _signaling.sendIceCandidate(f, t, c);
  @override Stream<Map<String, dynamic>?> watchOffer(String uid) => _signaling.watchOffer(uid);
  @override Stream<Map<String, dynamic>?> watchAnswer(String uid) => _signaling.watchAnswer(uid);
  @override Stream<Map<String, dynamic>?> watchCandidates(String uid) => _signaling.watchIceCandidates(uid);
  @override Future<void> clearSignals(String uid) => _signaling.clearSignals(uid);
}
