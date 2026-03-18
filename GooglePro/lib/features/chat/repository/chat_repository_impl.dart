import 'package:injectable/injectable.dart';
import '../datasource/chat_remote_datasource.dart';
import '../model/chat_message.dart';
import 'chat_repository.dart';
@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource _remote;
  ChatRepositoryImpl(this._remote);
  @override Future<void> sendMessage(String s, String t) => _remote.sendMessage(s, t);
  @override Stream<List<ChatMessage>> watchMessages(String s) => _remote.watchMessages(s);
  @override Future<List<ChatMessage>> fetchMessages(String s, {int limit = 50}) => _remote.fetchMessages(s, limit: limit);
  @override Future<void> markRead(String s) => _remote.markRead(s);
}
