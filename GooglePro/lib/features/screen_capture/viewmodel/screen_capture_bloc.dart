import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/screen_capture_manager.dart';
import '../state/screen_capture_state.dart';
import '../state/screen_capture_event.dart';
import '../../../core/utils/app_logger.dart';

class ScreenCaptureBloc extends Bloc<ScreenCaptureEvent, ScreenCaptureState> {
  final ScreenCaptureManager _manager;
  ScreenCaptureBloc(this._manager) : super(const ScreenCaptureIdle()) {
    on<StartCaptureEvent>(_onStart);
    on<StopCaptureEvent>(_onStop);
    on<PauseCaptureEvent>(_onPause);
    on<ResumeCaptureEvent>(_onResume);
    on<UpdateCaptureConfigEvent>(_onUpdateConfig);
  }

  Future<void> _onStart(StartCaptureEvent e, Emitter<ScreenCaptureState> emit) async {
    emit(const ScreenCaptureRequesting());
    try {
      await _manager.startCapture(targetDeviceId: e.targetDeviceId, config: e.config);
      emit(ScreenCaptureActive(config: e.config));
    } catch (e, s) {
      AppLogger.error('Capture start failed', e, s);
      emit(ScreenCaptureError(e.toString()));
    }
  }

  Future<void> _onStop(StopCaptureEvent e, Emitter<ScreenCaptureState> emit) async {
    await _manager.stopCapture();
    emit(const ScreenCaptureIdle());
  }

  void _onPause(PauseCaptureEvent e, Emitter<ScreenCaptureState> emit) {
    _manager.pauseCapture();
    emit(const ScreenCapturePaused());
  }

  void _onResume(ResumeCaptureEvent e, Emitter<ScreenCaptureState> emit) {
    _manager.resumeCapture();
    if (state is ScreenCapturePaused) emit(const ScreenCaptureActive(config: CaptureConfig()));
  }

  Future<void> _onUpdateConfig(UpdateCaptureConfigEvent e, Emitter<ScreenCaptureState> emit) async {
    await _manager.updateConfig(e.config);
    if (state is ScreenCaptureActive) emit(ScreenCaptureActive(config: e.config));
  }
}
