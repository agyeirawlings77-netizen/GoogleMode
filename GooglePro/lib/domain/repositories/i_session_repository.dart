import 'package:dartz/dartz.dart';
import '../entities/session_entity.dart';

abstract class ISessionRepository {
  Future<Either<String, SessionEntity>> startSession({required String hostId, required String viewerId, required SessionType type});
  Future<Either<String, void>> endSession(String sessionId);
  Future<Either<String, void>> pauseSession(String sessionId);
  Future<Either<String, void>> resumeSession(String sessionId);
  Future<List<SessionEntity>> getSessionHistory(String userId);
  Stream<SessionEntity?> watchActiveSession(String userId);
}
