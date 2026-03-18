import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/app_constants.dart';
import '../model/signaling_message.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class SignalingRepository {
  Future<void> sendOffer(String fromUid, String toUid, Map<String, dynamic> sdp) async {
    await FirebaseDatabase.instance.ref('${AppConstants.signalsPath}/$toUid/offer').set({'from': fromUid, 'sdp': sdp, 'timestamp': ServerValue.timestamp});
    AppLogger.info('Signaling: offer sent to $toUid');
  }

  Future<void> sendAnswer(String fromUid, String toUid, Map<String, dynamic> sdp) async {
    await FirebaseDatabase.instance.ref('${AppConstants.signalsPath}/$toUid/answer').set({'from': fromUid, 'sdp': sdp, 'timestamp': ServerValue.timestamp});
  }

  Future<void> sendIceCandidate(String fromUid, String toUid, Map<String, dynamic> candidate) async {
    await FirebaseDatabase.instance.ref('${AppConstants.signalsPath}/$toUid/candidates').push().set({'from': fromUid, ...candidate, 'timestamp': ServerValue.timestamp});
  }

  Stream<Map<String, dynamic>?> watchOffer(String uid) =>
    FirebaseDatabase.instance.ref('${AppConstants.signalsPath}/$uid/offer').onValue
      .map((e) => e.snapshot.value as Map<dynamic, dynamic>?)
      .map((m) => m?.map((k, v) => MapEntry(k.toString(), v)));

  Stream<Map<String, dynamic>?> watchAnswer(String uid) =>
    FirebaseDatabase.instance.ref('${AppConstants.signalsPath}/$uid/answer').onValue
      .map((e) => e.snapshot.value as Map<dynamic, dynamic>?)
      .map((m) => m?.map((k, v) => MapEntry(k.toString(), v)));

  Stream<Map<String, dynamic>?> watchIceCandidates(String uid) =>
    FirebaseDatabase.instance.ref('${AppConstants.signalsPath}/$uid/candidates').onChildAdded
      .map((e) => e.snapshot.value as Map<dynamic, dynamic>?)
      .map((m) => m?.map((k, v) => MapEntry(k.toString(), v)));

  Future<void> clearSignals(String uid) async {
    await FirebaseDatabase.instance.ref('${AppConstants.signalsPath}/$uid').remove();
  }
}
