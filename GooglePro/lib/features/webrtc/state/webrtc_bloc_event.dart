import 'package:equatable/equatable.dart';
import '../model/webrtc_state.dart';

abstract class WebRtcBlocEvent extends Equatable {
  const WebRtcBlocEvent();
  @override List<Object?> get props => [];
}
class InitializeWebRtcEvent extends WebRtcBlocEvent { const InitializeWebRtcEvent(); }
class StartScreenShareEvent extends WebRtcBlocEvent { const StartScreenShareEvent(); }
class StartAudioCallEvent extends WebRtcBlocEvent { const StartAudioCallEvent(); }
class CloseWebRtcEvent extends WebRtcBlocEvent { const CloseWebRtcEvent(); }
class ToggleVideoWebRtcEvent extends WebRtcBlocEvent { const ToggleVideoWebRtcEvent(); }
class ToggleAudioWebRtcEvent extends WebRtcBlocEvent { const ToggleAudioWebRtcEvent(); }
class StatsUpdatedEvent extends WebRtcBlocEvent {
  final WebRtcStats stats;
  const StatsUpdatedEvent(this.stats);
  @override List<Object?> get props => [stats];
}
