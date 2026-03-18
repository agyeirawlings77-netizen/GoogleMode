import 'package:injectable/injectable.dart';
import '../service/webrtc_service.dart';
@injectable
class StartScreenShareUsecase {
  final WebRtcService _service;
  StartScreenShareUsecase(this._service);
  Future<String> call(String localUid, String remoteUid) => _service.startScreenShare(localUid, remoteUid);
}
