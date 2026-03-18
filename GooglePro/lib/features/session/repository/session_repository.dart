import '../model/session_model.dart';
abstract class SessionRepository {
  Future<void> saveSession(SessionModel session);
  Future<void> endSession(String sessionId);
  Stream<List<SessionModel>> watchSessions(String uid);
}
