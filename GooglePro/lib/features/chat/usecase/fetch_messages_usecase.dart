import 'package:injectable/injectable.dart';
import '../model/chat_message.dart';
import '../repository/chat_repository.dart';
@injectable
class FetchMessagesUsecase {
  final ChatRepository _repo;
  FetchMessagesUsecase(this._repo);
  Future<List<ChatMessage>> call(String sessionId, {int limit = 50}) => _repo.fetchMessages(sessionId, limit: limit);
}
