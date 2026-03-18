import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({required super.messageId, required super.sessionId, required super.senderId, required super.senderName, required super.type, super.status, super.text, super.mediaUrl, super.metadata, required super.timestamp});

  factory MessageModel.fromJson(Map<String, dynamic> j) => MessageModel(messageId: j['messageId'] ?? '', sessionId: j['sessionId'] ?? '', senderId: j['senderId'] ?? '', senderName: j['senderName'] ?? '', type: MessageType.values.firstWhere((t) => t.name == j['type'], orElse: () => MessageType.text), status: MessageStatus.values.firstWhere((s) => s.name == j['status'], orElse: () => MessageStatus.sent), text: j['text'], mediaUrl: j['mediaUrl'], metadata: j['metadata'] as Map<String, dynamic>?, timestamp: j['timestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(j['timestamp'] as int) : DateTime.now());

  Map<String, dynamic> toJson() => {'messageId': messageId, 'sessionId': sessionId, 'senderId': senderId, 'senderName': senderName, 'type': type.name, 'status': status.name, 'text': text, 'mediaUrl': mediaUrl, 'metadata': metadata, 'timestamp': timestamp.millisecondsSinceEpoch};
}
