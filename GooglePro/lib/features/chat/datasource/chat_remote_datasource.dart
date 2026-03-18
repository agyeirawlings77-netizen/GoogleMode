import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../model/chat_message.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class ChatRemoteDatasource {
  final _db = FirebaseDatabase.instance;
  String get _myUid => FirebaseAuth.instance.currentUser?.uid ?? '';
  String get _myName => FirebaseAuth.instance.currentUser?.displayName ?? 'Me';

  Future<void> sendMessage(String sessionId, String text) async {
    final id = const Uuid().v4();
    final msg = {'messageId': id, 'sessionId': sessionId, 'senderId': _myUid, 'senderName': _myName, 'type': 'text', 'text': text, 'status': 'sent', 'timestamp': ServerValue.timestamp};
    await _db.ref('${AppConstants.chatPath}/$sessionId/messages/$id').set(msg);
    await _db.ref('${AppConstants.chatPath}/$sessionId/meta').update({'lastMessage': text, 'lastMessageAt': ServerValue.timestamp, 'lastSenderId': _myUid});
    AppLogger.debug('Chat: sent "$text" to session $sessionId');
  }

  Stream<List<ChatMessage>> watchMessages(String sessionId) {
    return _db.ref('${AppConstants.chatPath}/$sessionId/messages').orderByChild('timestamp').limitToLast(100).onValue.map((event) {
      if (!event.snapshot.exists) return <ChatMessage>[];
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      return data.values.map((v) => ChatMessage.fromJson(Map<String, dynamic>.from(v as Map), _myUid)).toList()
        ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    });
  }

  Future<List<ChatMessage>> fetchMessages(String sessionId, {int limit = 50}) async {
    final snap = await _db.ref('${AppConstants.chatPath}/$sessionId/messages').orderByChild('timestamp').limitToLast(limit).get();
    if (!snap.exists) return [];
    final data = snap.value as Map<dynamic, dynamic>;
    return data.values.map((v) => ChatMessage.fromJson(Map<String, dynamic>.from(v as Map), _myUid)).toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  Future<void> markRead(String sessionId) async {
    await _db.ref('${AppConstants.chatPath}/$sessionId/readers/$_myUid').set(ServerValue.timestamp);
  }
}
