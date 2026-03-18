enum MessageStatus { sending, sent, delivered, read, failed }
enum MessageType { text, image, file, audio, location, system }

class ChatMessage {
  final String messageId;
  final String sessionId;
  final String senderId;
  final String senderName;
  final String? senderAvatar;
  final MessageType type;
  final String? text;
  final String? mediaUrl;
  MessageStatus status;
  final DateTime timestamp;
  const ChatMessage({required this.messageId, required this.sessionId, required this.senderId, required this.senderName, this.senderAvatar, required this.type, this.text, this.mediaUrl, this.status = MessageStatus.sent, required this.timestamp});
  bool get isSentByMe => false; // overridden per context
  factory ChatMessage.fromJson(Map<String, dynamic> j) => ChatMessage(messageId: j['messageId'] ?? '', sessionId: j['sessionId'] ?? '', senderId: j['senderId'] ?? '', senderName: j['senderName'] ?? '', type: MessageType.values.firstWhere((t) => t.name == j['type'], orElse: () => MessageType.text), text: j['text'] as String?, mediaUrl: j['mediaUrl'] as String?, status: MessageStatus.values.firstWhere((s) => s.name == j['status'], orElse: () => MessageStatus.sent), timestamp: j['timestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(j['timestamp'] as int) : DateTime.now());
  Map<String, dynamic> toJson() => {'messageId': messageId, 'sessionId': sessionId, 'senderId': senderId, 'senderName': senderName, 'type': type.name, 'text': text, 'mediaUrl': mediaUrl, 'status': status.name, 'timestamp': timestamp.millisecondsSinceEpoch};
}
