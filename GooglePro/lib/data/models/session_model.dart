import '../../domain/entities/session_entity.dart';

class SessionModel extends SessionEntity {
  SessionModel({required super.sessionId, required super.hostId, required super.viewerId, required super.type, super.status, required super.startedAt, super.endedAt});

  factory SessionModel.fromJson(Map<String, dynamic> j) => SessionModel(sessionId: j['sessionId'] ?? '', hostId: j['hostId'] ?? '', viewerId: j['viewerId'] ?? '', type: SessionType.values.firstWhere((t) => t.name == j['type'], orElse: () => SessionType.screenShare), status: SessionStatus.values.firstWhere((s) => s.name == j['status'], orElse: () => SessionStatus.idle), startedAt: j['startedAt'] != null ? DateTime.tryParse(j['startedAt']) ?? DateTime.now() : DateTime.now(), endedAt: j['endedAt'] != null ? DateTime.tryParse(j['endedAt']) : null);

  Map<String, dynamic> toJson() => {'sessionId': sessionId, 'hostId': hostId, 'viewerId': viewerId, 'type': type.name, 'status': status.name, 'startedAt': startedAt.toIso8601String(), 'endedAt': endedAt?.toIso8601String()};
}
