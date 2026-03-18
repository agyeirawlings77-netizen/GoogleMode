import 'package:injectable/injectable.dart';
import '../signaling/firebase_signaling_datasource.dart';
@singleton
class WebRtcRemoteDatasource {
  final FirebaseSignalingDatasource _firebase;
  WebRtcRemoteDatasource(this._firebase);
  Future<void> publishOffer(String to, String from, Map<String, dynamic> sdp) => _firebase.publishOffer(to, from, sdp);
  Future<void> publishAnswer(String to, String from, Map<String, dynamic> sdp) => _firebase.publishAnswer(to, from, sdp);
  Future<void> publishCandidate(String to, String from, Map<String, dynamic> c) => _firebase.publishCandidate(to, from, c);
  Future<void> clear(String uid) => _firebase.clear(uid);
}
