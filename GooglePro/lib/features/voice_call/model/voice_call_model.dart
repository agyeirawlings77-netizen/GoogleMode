enum CallStatus { idle, calling, ringing, active, ended, missed, rejected }
enum CallType { voiceCall, walkie }

class VoiceCallModel {
  final String callId;
  final String callerId;
  final String callerName;
  final String receiverId;
  final String receiverName;
  CallStatus status;
  final CallType type;
  final DateTime startedAt;
  DateTime? endedAt;
  bool isMuted;
  bool isSpeakerOn;

  VoiceCallModel({required this.callId, required this.callerId, required this.callerName, required this.receiverId, required this.receiverName, this.status = CallStatus.idle, this.type = CallType.voiceCall, required this.startedAt, this.endedAt, this.isMuted = false, this.isSpeakerOn = false});

  Duration get duration => startedAt != null ? (endedAt ?? DateTime.now()).difference(startedAt) : Duration.zero;
  String get durationFormatted { final d = duration; final m = d.inMinutes.remainder(60).toString().padLeft(2,'0'); final s = d.inSeconds.remainder(60).toString().padLeft(2,'0'); return '$m:$s'; }
}
