import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import '../model/connection_stats.dart';
@injectable
class VideoQualityAdapter {
  static Future<void> adapt(RTCPeerConnection pc, ConnectionStats stats) async {
    int targetBitrate;
    if (stats.packetLoss > 5 || stats.roundTripMs > 300) {
      targetBitrate = 500;
    } else if (stats.packetLoss > 2 || stats.roundTripMs > 150) {
      targetBitrate = 1000;
    } else {
      targetBitrate = 2500;
    }
    final senders = await pc.getSenders();
    for (final sender in senders) {
      if (sender.track?.kind == 'video') {
        final params = await sender.getParameters();
        for (final enc in params.encodings ?? []) {
          enc.maxBitrate = targetBitrate * 1000;
        }
        await sender.setParameters(params);
      }
    }
  }
}
