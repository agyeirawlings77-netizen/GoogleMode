import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/app_constants.dart';

@singleton
class FirebaseSignalingDatasource {
  final _db = FirebaseDatabase.instance;

  Future<void> publishOffer(String toUid, String fromUid, Map<String, dynamic> sdp) =>
    _db.ref('${AppConstants.signalsPath}/$toUid/offer').set({'from': fromUid, 'sdp': sdp, 'ts': ServerValue.timestamp});

  Future<void> publishAnswer(String toUid, String fromUid, Map<String, dynamic> sdp) =>
    _db.ref('${AppConstants.signalsPath}/$toUid/answer').set({'from': fromUid, 'sdp': sdp, 'ts': ServerValue.timestamp});

  Future<void> publishCandidate(String toUid, String fromUid, Map<String, dynamic> c) =>
    _db.ref('${AppConstants.signalsPath}/$toUid/candidates').push().set({'from': fromUid, ...c, 'ts': ServerValue.timestamp});

  Stream<DatabaseEvent> offerStream(String uid) => _db.ref('${AppConstants.signalsPath}/$uid/offer').onValue;
  Stream<DatabaseEvent> answerStream(String uid) => _db.ref('${AppConstants.signalsPath}/$uid/answer').onValue;
  Stream<DatabaseEvent> candidateStream(String uid) => _db.ref('${AppConstants.signalsPath}/$uid/candidates').onChildAdded;

  Future<void> clear(String uid) => _db.ref('${AppConstants.signalsPath}/$uid').remove();
}
