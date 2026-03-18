import '../models/session_model.dart';
import '../../domain/entities/session_entity.dart';

class SessionMapper {
  static SessionModel fromJson(Map<String, dynamic> j) => SessionModel.fromJson(j);
  static Map<String, dynamic> toFirestore(SessionEntity e) => SessionModel(sessionId: e.sessionId, hostId: e.hostId, viewerId: e.viewerId, type: e.type, status: e.status, startedAt: e.startedAt).toJson();
}
