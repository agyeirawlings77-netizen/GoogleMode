import 'package:injectable/injectable.dart';
import '../service/voice_call_service.dart';
@injectable
class StartCallUsecase {
  final VoiceCallService _svc;
  StartCallUsecase(this._svc);
  Future<void> call() => _svc.startCall();
}
