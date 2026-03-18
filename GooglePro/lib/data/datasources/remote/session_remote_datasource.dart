import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../models/session_model.dart';
import '../../../domain/entities/session_entity.dart';

@singleton
class SessionRemoteDatasource {
  final FirebaseFirestore _firestore;
  SessionRemoteDatasource(this._firestore);

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> createSession(SessionModel session) => _firestore.collection('sessions').doc(session.sessionId).set(session.toJson());

  Future<void> updateSessionStatus(String sessionId, SessionStatus status) => _firestore.collection('sessions').doc(sessionId).update({'status': status.name, 'updatedAt': FieldValue.serverTimestamp()});

  Future<void> endSession(String sessionId) => _firestore.collection('sessions').doc(sessionId).update({'status': SessionStatus.ended.name, 'endedAt': FieldValue.serverTimestamp()});

  Future<List<SessionModel>> getHistory(String userId, {int limit = 20}) async {
    final snap = await _firestore.collection('sessions').where('hostId', isEqualTo: userId).orderBy('startedAt', descending: true).limit(limit).get();
    return snap.docs.map((d) => SessionModel.fromJson({...d.data(), 'sessionId': d.id})).toList();
  }

  Stream<SessionModel?> watchActiveSession(String userId) => _firestore.collection('sessions').where('hostId', isEqualTo: userId).where('status', isEqualTo: 'active').limit(1).snapshots()
    .map((s) => s.docs.isEmpty ? null : SessionModel.fromJson({...s.docs.first.data(), 'sessionId': s.docs.first.id}));
}
