import '../models/message_model.dart';
import '../../domain/entities/message_entity.dart';

class MessageMapper {
  static MessageModel fromJson(Map<String, dynamic> j) => MessageModel.fromJson(j);
  static Map<String, dynamic> toFirebase(MessageEntity e) => MessageModel(messageId: e.messageId, sessionId: e.sessionId, senderId: e.senderId, senderName: e.senderName, type: e.type, status: e.status, text: e.text, mediaUrl: e.mediaUrl, metadata: e.metadata, timestamp: e.timestamp).toJson();
}
