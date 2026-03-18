import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/screen_capture_service.dart';
import '../state/capture_state.dart';
import '../state/capture_event.dart';
import '../../../core/utils/app_logger.dart';

class CaptureBloc extends Bloc<CaptureEvent, CaptureState> {
  final ScreenCaptureService _svc;
  StreamSubscription? _statsSub;

  CaptureBloc(this._svc) : super(const CaptureIdle()) {
    on<StartCaptureEvent>(_onStart);
    on<StopCaptureEvent>(_onStop);
    on<ToggleAudioEvent>((e, emit) => _svc.toggleAudio());
    on<UpdateStatsEvent>((e, emit) { if (state is CaptureActive) emit((state as CaptureActive).copyWith(bitrateKbps: e.bitrateKbps, fps: e.fps)); });
  }

  Future<void> _onStart(StartCaptureEvent e, Emitter<CaptureState> emit) async {
    emit(const CaptureStarting());
    try {
      await _svc.startCapture(e.config);
      emit(CaptureActive(config: e.config));
      _statsSub = _svc.statsStream.listen((s) => add(UpdateStatsEvent(bitrateKbps: (s['bitrateKbps'] as num).toDouble(), fps: s['fps'] as int)));
    } catch (err) { AppLogger.error('Capture start failed', err); emit(CaptureError(err.toString())); }
  }

  Future<void> _onStop(StopCaptureEvent e, Emitter<CaptureState> emit) async {
    await _statsSub?.cancel();
    await _svc.stopCapture();
    emit(const CaptureStopped());
  }

  @override Future<void> close() async { await _statsSub?.cancel(); return super.close(); }
}
