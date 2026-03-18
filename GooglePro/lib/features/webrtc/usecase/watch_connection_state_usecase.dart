import 'package:injectable/injectable.dart';
import '../model/peer_connection_state.dart';
import '../service/webrtc_service.dart';
@injectable
class WatchConnectionStateUsecase {
  final WebRtcService _service;
  WatchConnectionStateUsecase(this._service);
  Stream<PeerConnectionState> call() => _service.stateStream;
}
