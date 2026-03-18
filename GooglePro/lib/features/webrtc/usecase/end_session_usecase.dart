import 'package:injectable/injectable.dart';
import '../service/webrtc_service.dart';
@injectable
class EndSessionUsecase {
  final WebRtcService _service;
  EndSessionUsecase(this._service);
  Future<void> call() => _service.endSession();
}
