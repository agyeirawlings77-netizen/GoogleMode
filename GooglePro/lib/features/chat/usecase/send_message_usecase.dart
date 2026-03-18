import 'package:injectable/injectable.dart';
import '../repository/chat_repository.dart';
@injectable
class SendMessageUsecase {
  final ChatRepository _repo;
  SendMessageUsecase(this._repo);
  Future<void> call(String sessionId, String text) => _repo.sendMessage(sessionId, text);
}
