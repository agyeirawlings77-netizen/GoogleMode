import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/utils/app_logger.dart';
@injectable
class ScreenFrameProcessor {
  Future<void> applyConstraints(RTCPeerConnection pc, {int fps = 15, int width = 1280, int height = 720}) async {
    final senders = await pc.getSenders();
    for (final sender in senders) {
      if (sender.track?.kind == 'video') {
        await sender.track?.applyConstraints({'frameRate': fps, 'width': width, 'height': height});
        AppLogger.debug('Applied constraints: ${fps}fps ${width}x$height');
      }
    }
  }
}
