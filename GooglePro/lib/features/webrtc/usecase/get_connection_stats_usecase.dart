import 'package:injectable/injectable.dart';
import '../model/connection_stats.dart';
import '../service/webrtc_service.dart';
@injectable
class GetConnectionStatsUsecase {
  final WebRtcService _service;
  GetConnectionStatsUsecase(this._service);
  Stream<ConnectionStats> call() => _service.statsStream;
}
