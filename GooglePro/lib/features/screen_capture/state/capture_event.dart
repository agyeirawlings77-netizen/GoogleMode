import 'package:equatable/equatable.dart';
import '../model/capture_config.dart';
abstract class CaptureEvent extends Equatable {
  const CaptureEvent();
  @override List<Object?> get props => [];
}
class StartCaptureEvent extends CaptureEvent {
  final CaptureConfig config;
  const StartCaptureEvent({this.config = const CaptureConfig()});
  @override List<Object?> get props => [config];
}
class StopCaptureEvent extends CaptureEvent { const StopCaptureEvent(); }
class ToggleAudioEvent extends CaptureEvent { const ToggleAudioEvent(); }
class UpdateStatsEvent extends CaptureEvent {
  final double bitrateKbps; final int fps;
  const UpdateStatsEvent({required this.bitrateKbps, required this.fps});
}
