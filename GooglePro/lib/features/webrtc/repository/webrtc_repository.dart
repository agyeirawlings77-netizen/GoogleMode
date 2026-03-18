import '../model/signaling_message.dart';
abstract class WebRtcRepository {
  Future<void> sendOffer(String from, String to, Map<String, dynamic> sdp);
  Future<void> sendAnswer(String from, String to, Map<String, dynamic> sdp);
  Future<void> sendCandidate(String from, String to, Map<String, dynamic> c);
  Stream<Map<String, dynamic>?> watchOffer(String uid);
  Stream<Map<String, dynamic>?> watchAnswer(String uid);
  Stream<Map<String, dynamic>?> watchCandidates(String uid);
  Future<void> clearSignals(String uid);
}
