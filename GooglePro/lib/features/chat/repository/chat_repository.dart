import '../model/chat_message.dart';
abstract class ChatRepository {
  Future<void> sendMessage(String sessionId, String text);
  Stream<List<ChatMessage>> watchMessages(String sessionId);
  Future<List<ChatMessage>> fetchMessages(String sessionId, {int limit});
  Future<void> markRead(String sessionId);
}
