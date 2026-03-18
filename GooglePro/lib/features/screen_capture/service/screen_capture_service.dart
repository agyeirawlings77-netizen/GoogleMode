import 'dart:async';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:injectable/injectable.dart';
import '../model/capture_config.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class ScreenCaptureService {
  MediaStream? _stream;
  bool _capturing = false;
  final _statsCtrl = StreamController<Map<String, dynamic>>.broadcast();
  Timer? _statsTimer;

  bool get isCapturing => _capturing;
  MediaStream? get stream => _stream;
  Stream<Map<String, dynamic>> get statsStream => _statsCtrl.stream;

  Future<MediaStream> startCapture(CaptureConfig config) async {
    if (_capturing) await stopCapture();
    _stream = await navigator.mediaDevices.getDisplayMedia({'video': {'width': config.width, 'height': config.height, 'frameRate': config.fps}, 'audio': config.audioEnabled});
    _capturing = true;
    _statsTimer = Timer.periodic(const Duration(seconds: 2), (_) => _statsCtrl.add({'bitrateKbps': config.bitrateKbps.toDouble(), 'fps': config.fps}));
    AppLogger.info('Screen capture started: ${config.width}x${config.height}@${config.fps}');
    return _stream!;
  }

  Future<void> stopCapture() async {
    _statsTimer?.cancel();
    _stream?.getTracks().forEach((t) => t.stop());
    await _stream?.dispose();
    _stream = null;
    _capturing = false;
    AppLogger.info('Screen capture stopped');
  }

  void toggleAudio() => _stream?.getAudioTracks().forEach((t) => t.enabled = !t.enabled);
  void dispose() { stopCapture(); _statsCtrl.close(); }
}
