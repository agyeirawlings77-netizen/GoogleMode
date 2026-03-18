import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import '../service/video_quality_adapter.dart';
import '../model/connection_stats.dart';
@injectable
class SetVideoQualityUsecase {
  Future<void> call(RTCPeerConnection pc, ConnectionStats stats) => VideoQualityAdapter.adapt(pc, stats);
}
