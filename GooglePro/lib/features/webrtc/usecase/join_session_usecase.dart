import 'package:injectable/injectable.dart';
import '../service/webrtc_service.dart';
@injectable
class JoinSessionUsecase {
  final WebRtcService _service;
  JoinSessionUsecase(this._service);
  Future<void> call(String localUid, String remoteUid, Map<String, dynamic> offer) => _service.joinSession(localUid, remoteUid, offer);
}
