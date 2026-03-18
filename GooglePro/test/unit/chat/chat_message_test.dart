import 'package:flutter_test/flutter_test.dart';
import 'package:googlepro/features/chat/model/chat_message.dart';

void main() {
  group('ChatMessage', () {
    test('fromJson/toJson round trip', () {
      final msg = ChatMessage(messageId: 'm1', sessionId: 's1', senderId: 'uid1', senderName: 'Alice', type: MessageType.text, text: 'Hello!', timestamp: DateTime(2024, 1, 1, 12, 0));
      final json = msg.toJson();
      final restored = ChatMessage.fromJson(json);
      expect(restored.messageId, msg.messageId);
      expect(restored.text, 'Hello!');
      expect(restored.senderName, 'Alice');
    });
    test('status defaults to sent', () {
      final msg = ChatMessage(messageId: 'm1', sessionId: 's1', senderId: 'uid1', senderName: 'Bob', type: MessageType.text, timestamp: DateTime.now());
      expect(msg.status, MessageStatus.sent);
    });
    test('text message type is correct', () {
      final msg = ChatMessage(messageId: 'm1', sessionId: 's1', senderId: 'uid1', senderName: 'Bob', type: MessageType.text, text: 'Test', timestamp: DateTime.now());
      expect(msg.type, MessageType.text);
    });
  });
}
