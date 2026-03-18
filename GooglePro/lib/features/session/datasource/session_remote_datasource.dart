import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../model/session_model.dart';

@singleton
class SessionRemoteDatasource {
  final FirebaseFirestore _firestore;
  SessionRemoteDatasource(this._firestore);

  Future<void> saveSession(SessionModel s) =>
    _firestore.collection('sessions').doc(s.sessionId).set(s.toJson(), SetOptions(merge: true));

  Future<void> endSession(String sessionId) =>
    _firestore.collection('sessions').doc(sessionId).update({'status': 'ended', 'endedAt': FieldValue.serverTimestamp()});

  Stream<List<SessionModel>> watchSessions(String uid) =>
    _firestore.collection('sessions').where('hostUserId', isEqualTo: uid).orderBy('startedAt', descending: true).limit(20).snapshots()
      .map((s) => s.docs.map((d) => SessionModel.fromJson({...d.data(), 'sessionId': d.id})).toList());
}
