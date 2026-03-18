import 'package:injectable/injectable.dart';
import '../model/chat_message.dart';
import '../repository/chat_repository.dart';
@injectable
class WatchMessagesUsecase {
  final ChatRepository _repo;
  WatchMessagesUsecase(this._repo);
  Stream<List<ChatMessage>> call(String sessionId) => _repo.watchMessages(sessionId);
}
