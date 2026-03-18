import 'package:equatable/equatable.dart';
import '../model/capture_config.dart';

abstract class ScreenCaptureEvent extends Equatable {
  const ScreenCaptureEvent();
  @override List<Object?> get props => [];
}
class StartCaptureEvent extends ScreenCaptureEvent {
  final CaptureConfig config;
  final String targetDeviceId;
  const StartCaptureEvent({required this.config, required this.targetDeviceId});
  @override List<Object?> get props => [targetDeviceId];
}
class StopCaptureEvent extends ScreenCaptureEvent { const StopCaptureEvent(); }
class PauseCaptureEvent extends ScreenCaptureEvent { const PauseCaptureEvent(); }
class ResumeCaptureEvent extends ScreenCaptureEvent { const ResumeCaptureEvent(); }
class UpdateCaptureConfigEvent extends ScreenCaptureEvent {
  final CaptureConfig config;
  const UpdateCaptureConfigEvent(this.config);
  @override List<Object?> get props => [config];
}
