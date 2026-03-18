import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:go_router/go_router.dart';
import '../viewmodel/session_bloc.dart';
import '../state/session_bloc_state.dart';
import '../state/session_bloc_event.dart';
import '../../webrtc/model/webrtc_state.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class ScreenViewerScreen extends StatefulWidget {
  final String deviceId;
  const ScreenViewerScreen({super.key, required this.deviceId});
  @override State<ScreenViewerScreen> createState() => _ScreenViewerScreenState();
}

class _ScreenViewerScreenState extends State<ScreenViewerScreen> {
  late final SessionBloc _bloc;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _bloc = SessionBloc(getIt(), getIt());
  }

  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<SessionBloc, SessionBlocState>(
        listener: (ctx, state) {
          if (state is SessionEnded || state is SessionError) context.pop();
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: GestureDetector(
            onTap: () => setState(() => _showControls = !_showControls),
            child: Stack(children: [
              // Remote video fill screen
              BlocBuilder<SessionBloc, SessionBlocState>(builder: (ctx, state) {
                final webRtcSvc = getIt<dynamic>();
                if (webRtcSvc?.remoteRenderer != null) {
                  return RTCVideoView(webRtcSvc.remoteRenderer!, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitContain);
                }
                return const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor));
              }),

              // Connecting overlay
              BlocBuilder<SessionBloc, SessionBlocState>(builder: (ctx, state) {
                if (state is SessionConnecting) return Container(color: Colors.black87, child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const CircularProgressIndicator(color: AppTheme.primaryColor).animate(onPlay: (c) => c.repeat()).rotate(duration: 1200.ms),
                  const SizedBox(height: 20),
                  Text('Connecting to ${state.deviceName}...', style: const TextStyle(color: Colors.white, fontSize: 16)),
                ])));
                return const SizedBox.shrink();
              }),

              // Top controls
              AnimatedOpacity(opacity: _showControls ? 1.0 : 0.0, duration: const Duration(milliseconds: 200),
                child: SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
                  IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () { _bloc.add(const EndSessionEvent()); context.pop(); }),
                  BlocBuilder<SessionBloc, SessionBlocState>(builder: (ctx, state) {
                    if (state is SessionActive) return Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                      Text(state.deviceName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      Text(state.stats.qualityLabel, style: TextStyle(color: state.stats.qualityScore > 0.7 ? AppTheme.successColor : AppTheme.warningColor, fontSize: 12)),
                    ]));
                    return const Spacer();
                  }),
                ])))),

              // Bottom controls
              AnimatedOpacity(opacity: _showControls ? 1.0 : 0.0, duration: const Duration(milliseconds: 200),
                child: Align(alignment: Alignment.bottomCenter, child: SafeArea(child: Padding(padding: const EdgeInsets.all(16),
                  child: BlocBuilder<SessionBloc, SessionBlocState>(builder: (ctx, state) {
                    final isActive = state is SessionActive;
                    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      _controlBtn(Icons.mic_off, 'Mute', isActive && !state.audioEnabled ? AppTheme.errorColor : Colors.white70, () => _bloc.add(const ToggleAudioEvent())),
                      _controlBtn(Icons.videocam_off, 'Video', isActive && !state.videoEnabled ? AppTheme.errorColor : Colors.white70, () => _bloc.add(const ToggleVideoEvent())),
                      _controlBtn(Icons.call_end, 'End', AppTheme.errorColor, () { _bloc.add(const EndSessionEvent()); context.pop(); }),
                      _controlBtn(Icons.chat_bubble_outline, 'Chat', Colors.white70, () {}),
                      _controlBtn(Icons.more_vert, 'More', Colors.white70, () {}),
                    ]);
                  }),
                )))),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _controlBtn(IconData icon, String label, Color color, VoidCallback onTap) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Material(color: Colors.black54, shape: const CircleBorder(), child: InkWell(onTap: onTap, customBorder: const CircleBorder(), child: Padding(padding: const EdgeInsets.all(12), child: Icon(icon, color: color, size: 24)))),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
    ]);
  }
}
