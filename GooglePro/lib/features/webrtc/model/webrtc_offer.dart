class WebRtcOffer {
  final String fromUserId;
  final String toUserId;
  final String sdp;
  final String type;
  final int timestamp;
  const WebRtcOffer({required this.fromUserId, required this.toUserId, required this.sdp, required this.type, required this.timestamp});
  factory WebRtcOffer.fromJson(Map<String, dynamic> j) => WebRtcOffer(fromUserId: j['fromUserId'] ?? j['from'] ?? '', toUserId: j['toUserId'] ?? j['to'] ?? '', sdp: j['sdp'] ?? '', type: j['type'] ?? '', timestamp: j['timestamp'] ?? 0);
  Map<String, dynamic> toJson() => {'fromUserId': fromUserId, 'toUserId': toUserId, 'sdp': sdp, 'type': type, 'timestamp': timestamp};
}
