import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/capture_state.dart';
import '../state/capture_event.dart';
import '../viewmodel/capture_bloc.dart';
import '../widget/capture_controls_overlay.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class ScreenCaptureScreen extends StatefulWidget {
  final String deviceId;
  const ScreenCaptureScreen({super.key, required this.deviceId});
  @override State<ScreenCaptureScreen> createState() => _ScreenCaptureScreenState();
}

class _ScreenCaptureScreenState extends State<ScreenCaptureScreen> {
  late final CaptureBloc _bloc;
  bool _showControls = true;
  @override void initState() { super.initState(); _bloc = CaptureBloc(getIt())..add(const StartCaptureEvent()); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<CaptureBloc, CaptureState>(
        listener: (ctx, state) { if (state is CaptureStopped || state is CaptureError) context.pop(); },
        child: Scaffold(backgroundColor: Colors.black,
          body: GestureDetector(onTap: () => setState(() => _showControls = !_showControls),
            child: Stack(children: [
              Container(color: Colors.black, child: const Center(child: Icon(Icons.screen_share_rounded, color: AppTheme.primaryColor, size: 80))),
              BlocBuilder<CaptureBloc, CaptureState>(builder: (ctx, state) => CaptureControlsOverlay(state: state, visible: _showControls, onStop: () => _bloc.add(const StopCaptureEvent()), onToggleAudio: () => _bloc.add(const ToggleAudioEvent()))),
              BlocBuilder<CaptureBloc, CaptureState>(builder: (ctx, state) {
                if (state is CaptureStarting) return Container(color: Colors.black87, child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const CircularProgressIndicator(color: AppTheme.primaryColor).animate(onPlay: (c) => c.repeat()).rotate(), const SizedBox(height: 16), const Text('Starting screen capture...', style: TextStyle(color: Colors.white, fontSize: 15))])));
                return const SizedBox.shrink();
              }),
            ])),
        ),
      ),
    );
  }
}
