import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import '../model/capture_config.dart';
import '../../webrtc/service/webrtc_service.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class ScreenCaptureManager {
  final WebRtcService _webrtc;
  MediaStream? _stream;
  bool _isCapturing = false;
  bool _isPaused = false;
  final _statsController = StreamController<Map<String, double>>.broadcast();

  ScreenCaptureManager(this._webrtc);

  bool get isCapturing => _isCapturing;
  bool get isPaused => _isPaused;
  Stream<Map<String, double>> get statsStream => _statsController.stream;

  Future<String> startCapture({required String targetDeviceId, required CaptureConfig config}) async {
    AppLogger.info('ScreenCapture: starting → $targetDeviceId at ${config.fps}fps ${config.bitrateKbps}kbps');
    try {
      final stream = await navigator.mediaDevices.getDisplayMedia({'video': true, 'audio': config.includeAudio});
      _stream = stream;
      _isCapturing = true;
      _isPaused = false;
      _stream!.getTracks().forEach((t) {
        t.applyConstraints({'frameRate': config.fps, 'width': config.width, 'height': config.height});
        t.onEnded = () { _isCapturing = false; AppLogger.info('Screen track ended by OS'); };
      });
      final sessionId = await _webrtc.startScreenShare(targetDeviceId, targetDeviceId);
      return sessionId;
    } catch (e, s) {
      AppLogger.error('ScreenCapture start failed', e, s);
      rethrow;
    }
  }

  Future<void> stopCapture() async {
    _stream?.getTracks().forEach((t) => t.stop());
    await _stream?.dispose();
    _stream = null;
    _isCapturing = false;
    _isPaused = false;
    await _webrtc.endSession();
    AppLogger.info('ScreenCapture: stopped');
  }

  void pauseCapture() {
    _stream?.getVideoTracks().forEach((t) => t.enabled = false);
    _isPaused = true;
    AppLogger.info('ScreenCapture: paused');
  }

  void resumeCapture() {
    _stream?.getVideoTracks().forEach((t) => t.enabled = true);
    _isPaused = false;
    AppLogger.info('ScreenCapture: resumed');
  }

  Future<void> updateConfig(CaptureConfig config) async {
    _stream?.getVideoTracks().forEach((t) => t.applyConstraints({'frameRate': config.fps, 'width': config.width, 'height': config.height}));
  }

  void dispose() { stopCapture(); _statsController.close(); }
}
