enum SignalingMessageType { offer, answer, candidate, bye, ready, ping, pong, heartbeat, autoConnect }

class SignalingMessage {
  final SignalingMessageType type;
  final String from;
  final String to;
  final Map<String, dynamic>? payload;
  final int timestamp;
  const SignalingMessage({required this.type, required this.from, required this.to, this.payload, required this.timestamp});
  factory SignalingMessage.fromJson(Map<String, dynamic> j) => SignalingMessage(type: SignalingMessageType.values.firstWhere((t) => t.name == j['type'], orElse: () => SignalingMessageType.ping), from: j['from'] ?? '', to: j['to'] ?? '', payload: j['payload'] as Map<String, dynamic>?, timestamp: j['ts'] as int? ?? DateTime.now().millisecondsSinceEpoch);
  Map<String, dynamic> toJson() => {'type': type.name, 'from': from, 'to': to, 'payload': payload, 'ts': timestamp};
  factory SignalingMessage.offer(String from, String to, Map<String, dynamic> sdp) => SignalingMessage(type: SignalingMessageType.offer, from: from, to: to, payload: {'sdp': sdp}, timestamp: DateTime.now().millisecondsSinceEpoch);
  factory SignalingMessage.answer(String from, String to, Map<String, dynamic> sdp) => SignalingMessage(type: SignalingMessageType.answer, from: from, to: to, payload: {'sdp': sdp}, timestamp: DateTime.now().millisecondsSinceEpoch);
  factory SignalingMessage.candidate(String from, String to, Map<String, dynamic> c) => SignalingMessage(type: SignalingMessageType.candidate, from: from, to: to, payload: {'candidate': c}, timestamp: DateTime.now().millisecondsSinceEpoch);
  factory SignalingMessage.bye(String from, String to) => SignalingMessage(type: SignalingMessageType.bye, from: from, to: to, timestamp: DateTime.now().millisecondsSinceEpoch);
}
