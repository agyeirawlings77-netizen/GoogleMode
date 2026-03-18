import 'package:injectable/injectable.dart';
import '../service/gemini_service.dart';
@injectable
class SendAiMessageUsecase {
  final GeminiService _svc;
  SendAiMessageUsecase(this._svc);
  Future<String> call(String message) => _svc.sendMessage(message);
}
