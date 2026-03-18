import 'package:equatable/equatable.dart';
import '../model/capture_config.dart';
abstract class CaptureState extends Equatable {
  const CaptureState();
  @override List<Object?> get props => [];
}
class CaptureIdle extends CaptureState { const CaptureIdle(); }
class CaptureStarting extends CaptureState { const CaptureStarting(); }
class CaptureActive extends CaptureState {
  final CaptureConfig config;
  final double bitrateKbps;
  final int fps;
  const CaptureActive({required this.config, this.bitrateKbps = 0, this.fps = 0});
  @override List<Object?> get props => [config, bitrateKbps, fps];
  CaptureActive copyWith({double? bitrateKbps, int? fps}) => CaptureActive(config: config, bitrateKbps: bitrateKbps ?? this.bitrateKbps, fps: fps ?? this.fps);
}
class CaptureStopped extends CaptureState { const CaptureStopped(); }
class CaptureError extends CaptureState {
  final String message;
  const CaptureError(this.message);
  @override List<Object?> get props => [message];
}
