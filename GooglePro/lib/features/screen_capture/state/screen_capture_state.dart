import 'package:equatable/equatable.dart';
import '../model/capture_config.dart';

abstract class ScreenCaptureState extends Equatable {
  const ScreenCaptureState();
  @override List<Object?> get props => [];
}
class ScreenCaptureIdle extends ScreenCaptureState { const ScreenCaptureIdle(); }
class ScreenCaptureRequesting extends ScreenCaptureState { const ScreenCaptureRequesting(); }
class ScreenCaptureActive extends ScreenCaptureState {
  final CaptureConfig config;
  final double actualFps;
  final int actualBitrateKbps;
  const ScreenCaptureActive({required this.config, this.actualFps = 0, this.actualBitrateKbps = 0});
  @override List<Object?> get props => [config, actualFps];
}
class ScreenCapturePaused extends ScreenCaptureState { const ScreenCapturePaused(); }
class ScreenCaptureError extends ScreenCaptureState {
  final String message;
  const ScreenCaptureError(this.message);
  @override List<Object?> get props => [message];
}
