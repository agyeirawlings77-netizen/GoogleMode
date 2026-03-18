import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import '../model/webrtc_config.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class ScreenCaptureService {
  MediaStream? _screenStream;
  bool _isCapturing = false;

  bool get isCapturing => _isCapturing;

  Future<MediaStream> startCapture() async {
    try {
      AppLogger.info('Starting screen capture');
      _screenStream = await navigator.mediaDevices.getDisplayMedia(WebRtcConfig.screenConstraints);
      _isCapturing = true;
      _screenStream!.getTracks().forEach((t) {
        t.onEnded = () { _isCapturing = false; AppLogger.info('Screen track ended'); };
      });
      return _screenStream!;
    } catch (e, s) {
      AppLogger.error('Screen capture failed', e, s);
      rethrow;
    }
  }

  Future<void> stopCapture() async {
    _screenStream?.getTracks().forEach((t) => t.stop());
    await _screenStream?.dispose();
    _screenStream = null;
    _isCapturing = false;
    AppLogger.info('Screen capture stopped');
  }

  Future<void> setBitrate(RTCPeerConnection pc, int bitrateKbps) async {
    final senders = await pc.getSenders();
    for (final sender in senders) {
      if (sender.track?.kind == 'video') {
        final params = await sender.getParameters();
        for (final enc in params.encodings ?? []) {
          enc.maxBitrate = bitrateKbps * 1000;
        }
        await sender.setParameters(params);
      }
    }
  }
}
