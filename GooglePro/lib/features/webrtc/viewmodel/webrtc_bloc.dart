import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/webrtc_service.dart';
import '../service/stats_collector.dart';
import '../model/webrtc_state.dart';
import '../state/webrtc_bloc_state.dart';
import '../state/webrtc_bloc_event.dart';
import '../../../core/utils/app_logger.dart';

class WebRtcBloc extends Bloc<WebRtcBlocEvent, WebRtcBlocState> {
  final WebRtcService _svc;
  final StatsCollector _stats;
  StreamSubscription? _statsSub;

  WebRtcBloc(this._svc, this._stats) : super(const WebRtcIdle()) {
    on<InitializeWebRtcEvent>(_onInit);
    on<StartScreenShareEvent>(_onScreenShare);
    on<StartAudioCallEvent>(_onAudioCall);
    on<CloseWebRtcEvent>(_onClose);
    on<ToggleVideoWebRtcEvent>(_onToggleVideo);
    on<ToggleAudioWebRtcEvent>(_onToggleAudio);
    on<StatsUpdatedEvent>(_onStats);
  }

  Future<void> _onInit(InitializeWebRtcEvent e, Emitter<WebRtcBlocState> emit) async {
    emit(const WebRtcConnecting());
    try {
      await _svc.initialize();
      await _svc.createPeerConnection();
      _statsSub = _stats.statsStream.listen((s) => add(StatsUpdatedEvent(s)));
      emit(WebRtcConnected(remoteRenderer: _svc.remoteRenderer, localRenderer: _svc.localRenderer));
    } catch (err) { emit(WebRtcFailed(err.toString())); }
  }

  Future<void> _onScreenShare(StartScreenShareEvent e, Emitter<WebRtcBlocState> emit) async {
    try { await _svc.startScreenCapture(); } catch (err) { AppLogger.error('Screen share failed', err); }
  }

  Future<void> _onAudioCall(StartAudioCallEvent e, Emitter<WebRtcBlocState> emit) async {
    try { await _svc.startAudioOnly(); } catch (err) { AppLogger.error('Audio call failed', err); }
  }

  Future<void> _onClose(CloseWebRtcEvent e, Emitter<WebRtcBlocState> emit) async {
    await _statsSub?.cancel();
    _stats.stop();
    await _svc.close();
    emit(const WebRtcClosed());
  }

  void _onToggleVideo(ToggleVideoWebRtcEvent e, Emitter<WebRtcBlocState> emit) {
    if (state is WebRtcConnected) {
      final s = state as WebRtcConnected;
      _svc.setVideoEnabled(s.stats.fps == 0);
    }
  }

  void _onToggleAudio(ToggleAudioWebRtcEvent e, Emitter<WebRtcBlocState> emit) => _svc.setAudioEnabled(true);

  void _onStats(StatsUpdatedEvent e, Emitter<WebRtcBlocState> emit) {
    if (state is WebRtcConnected) emit((state as WebRtcConnected).copyWith(stats: e.stats));
  }

  @override Future<void> close() async { await _statsSub?.cancel(); await _svc.close(); return super.close(); }
}
