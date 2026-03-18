enum SessionEventType { started, ended, paused, resumed, error, screenshot, recording }
class SessionEventModel {
  final String sessionId;
  final SessionEventType type;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;
  const SessionEventModel({required this.sessionId, required this.type, required this.timestamp, this.metadata});
}
