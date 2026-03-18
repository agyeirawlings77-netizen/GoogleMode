enum CallStatus { idle, ringing, connecting, active, ended, declined, missed }
enum CallDirection { incoming, outgoing }

class CallModel {
  final String callId;
  final String callerId;
  final String callerName;
  final String? callerAvatar;
  final String receiverId;
  final CallStatus status;
  final CallDirection direction;
  final DateTime startedAt;
  final DateTime? connectedAt;
  final DateTime? endedAt;
  bool isMuted;
  bool isSpeakerOn;
  const CallModel({required this.callId, required this.callerId, required this.callerName, this.callerAvatar, required this.receiverId, required this.status, required this.direction, required this.startedAt, this.connectedAt, this.endedAt, this.isMuted = false, this.isSpeakerOn = false});
  Duration get duration => connectedAt != null ? (endedAt ?? DateTime.now()).difference(connectedAt!) : Duration.zero;
  bool get isActive => status == CallStatus.active;
}
