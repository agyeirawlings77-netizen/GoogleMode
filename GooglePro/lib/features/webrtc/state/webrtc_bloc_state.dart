import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../model/webrtc_state.dart';

abstract class WebRtcBlocState extends Equatable {
  const WebRtcBlocState();
  @override List<Object?> get props => [];
}
class WebRtcIdle extends WebRtcBlocState { const WebRtcIdle(); }
class WebRtcConnecting extends WebRtcBlocState { const WebRtcConnecting(); }
class WebRtcConnected extends WebRtcBlocState {
  final RTCVideoRenderer? remoteRenderer;
  final RTCVideoRenderer? localRenderer;
  final WebRtcStats stats;
  const WebRtcConnected({this.remoteRenderer, this.localRenderer, this.stats = const WebRtcStats()});
  @override List<Object?> get props => [stats];
  WebRtcConnected copyWith({WebRtcStats? stats}) => WebRtcConnected(remoteRenderer: remoteRenderer, localRenderer: localRenderer, stats: stats ?? this.stats);
}
class WebRtcFailed extends WebRtcBlocState {
  final String reason;
  const WebRtcFailed(this.reason);
  @override List<Object?> get props => [reason];
}
class WebRtcClosed extends WebRtcBlocState { const WebRtcClosed(); }
