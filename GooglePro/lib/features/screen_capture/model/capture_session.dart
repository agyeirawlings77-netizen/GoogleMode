import 'capture_config.dart';
import 'capture_status.dart';
class CaptureSession {
  final String sessionId;
  final String targetDeviceId;
  final CaptureConfig config;
  final CaptureStatus status;
  final DateTime startedAt;
  final int frameCount;
  final double avgFps;
  const CaptureSession({required this.sessionId, required this.targetDeviceId, required this.config, required this.status, required this.startedAt, this.frameCount = 0, this.avgFps = 0.0});
  Duration get duration => DateTime.now().difference(startedAt);
  CaptureSession copyWith({CaptureStatus? status, int? frameCount, double? avgFps}) =>
    CaptureSession(sessionId: sessionId, targetDeviceId: targetDeviceId, config: config, status: status ?? this.status, startedAt: startedAt, frameCount: frameCount ?? this.frameCount, avgFps: avgFps ?? this.avgFps);
}
