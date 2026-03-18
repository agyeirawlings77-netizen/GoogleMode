import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../model/chat_message.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class ChatService {
  final _db = FirebaseDatabase.instance;
  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';
  String get _name => FirebaseAuth.instance.currentUser?.displayName ?? 'Me';

  Future<void> sendMessage({required String sessionId, required String text}) async {
    final id = const Uuid().v4();
    await _db.ref('${AppConstants.chatPath}/$sessionId/messages/$id').set({'messageId': id, 'sessionId': sessionId, 'senderId': _uid, 'senderName': _name, 'type': 'text', 'text': text, 'status': 'sent', 'timestamp': ServerValue.timestamp});
    AppLogger.debug('Chat: sent "$text" to $sessionId');
  }

  Future<List<ChatMessage>> getMessages(String sessionId, {int limit = 50}) async {
    final snap = await _db.ref('${AppConstants.chatPath}/$sessionId/messages').orderByChild('timestamp').limitToLast(limit).get();
    if (!snap.exists) return [];
    final data = snap.value as Map<dynamic, dynamic>;
    return data.values.map((v) => ChatMessage.fromJson(Map<String, dynamic>.from(v as Map))).toList()..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  Stream<List<ChatMessage>> watchMessages(String sessionId) => _db.ref('${AppConstants.chatPath}/$sessionId/messages').orderByChild('timestamp').limitToLast(100).onValue.map((e) {
    if (!e.snapshot.exists) return <ChatMessage>[];
    final data = e.snapshot.value as Map<dynamic, dynamic>;
    return data.values.map((v) => ChatMessage.fromJson(Map<String, dynamic>.from(v as Map))).toList()..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  });

  Future<void> markRead(String sessionId) => _db.ref('${AppConstants.chatPath}/$sessionId/read/$_uid').set(ServerValue.timestamp);

  Stream<bool> watchTypingIndicator(String sessionId, String otherUserId) => _db.ref('${AppConstants.chatPath}/$sessionId/typing/$otherUserId').onValue.map((e) => e.snapshot.value as bool? ?? false);

  Future<void> setTyping(String sessionId, bool typing) => _db.ref('${AppConstants.chatPath}/$sessionId/typing/$_uid').set(typing);
}
