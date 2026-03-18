import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../../models/message_model.dart';
import '../../../core/constants/app_constants.dart';
import '../../../domain/entities/message_entity.dart';

@singleton
class MessageRemoteDatasource {
  final FirebaseDatabase _rtdb;
  MessageRemoteDatasource(this._rtdb);

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> sendMessage(String sessionId, String text, String senderName) async {
    final id = const Uuid().v4();
    await _rtdb.ref('${AppConstants.chatPath}/$sessionId/messages/$id').set({'messageId': id, 'sessionId': sessionId, 'senderId': _uid, 'senderName': senderName, 'type': 'text', 'text': text, 'status': 'sent', 'timestamp': ServerValue.timestamp});
  }

  Future<List<MessageModel>> getMessages(String sessionId, {int limit = 50}) async {
    final snap = await _rtdb.ref('${AppConstants.chatPath}/$sessionId/messages').orderByChild('timestamp').limitToLast(limit).get();
    if (!snap.exists) return [];
    final data = snap.value as Map<dynamic, dynamic>;
    return data.values.map((v) => MessageModel.fromJson(Map<String, dynamic>.from(v as Map))).toList()..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  Stream<List<MessageModel>> watchMessages(String sessionId) => _rtdb.ref('${AppConstants.chatPath}/$sessionId/messages').orderByChild('timestamp').limitToLast(100).onValue
    .map((e) {
      if (!e.snapshot.exists) return <MessageModel>[];
      final data = e.snapshot.value as Map<dynamic, dynamic>;
      return data.values.map((v) => MessageModel.fromJson(Map<String, dynamic>.from(v as Map))).toList()..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    });
}
