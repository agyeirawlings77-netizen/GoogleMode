import 'package:dartz/dartz.dart';
import '../entities/message_entity.dart';

abstract class IMessageRepository {
  Future<Either<String, void>> sendMessage({required String sessionId, required String text, required String senderId, required String senderName});
  Future<Either<String, List<MessageEntity>>> getMessages(String sessionId, {int limit = 50});
  Stream<List<MessageEntity>> watchMessages(String sessionId);
  Future<Either<String, void>> markRead(String sessionId, String userId);
  Future<Either<String, void>> deleteMessage(String sessionId, String messageId);
}
