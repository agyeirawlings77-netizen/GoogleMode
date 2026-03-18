import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/call_state.dart';
import '../state/call_event.dart';
import '../viewmodel/call_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class VoiceCallScreen extends StatefulWidget {
  final String deviceId;
  final String deviceName;
  const VoiceCallScreen({super.key, required this.deviceId, required this.deviceName});
  @override State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  late final CallBloc _bloc;
  @override void initState() { super.initState(); _bloc = CallBloc(getIt())..add(StartCallEvent(deviceId: widget.deviceId, deviceName: widget.deviceName)); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<CallBloc, CallState>(
        listener: (ctx, state) { if (state is CallEnded || state is CallDeclined) context.pop(); },
        child: Scaffold(
          backgroundColor: AppTheme.darkBg,
          body: SafeArea(child: BlocBuilder<CallBloc, CallState>(builder: (ctx, state) {
            return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              // Top — caller info
              Padding(padding: const EdgeInsets.all(32), child: Column(children: [
                const SizedBox(height: 40),
                CircleAvatar(radius: 52, backgroundColor: AppTheme.primaryColor.withOpacity(0.15), child: Text(widget.deviceName.isNotEmpty ? widget.deviceName[0].toUpperCase() : '?', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 36, fontWeight: FontWeight.w700))).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(begin: 1.0, end: 1.04, duration: 1500.ms),
                const SizedBox(height: 20),
                Text(widget.deviceName, style: const TextStyle(color: AppTheme.darkText, fontSize: 26, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(_callStatus(state), style: TextStyle(color: _statusColor(state), fontSize: 15)),
              ])),

              // Controls
              Padding(padding: const EdgeInsets.all(32), child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _controlBtn(state is CallActive && state.call.isMuted ? Icons.mic_off : Icons.mic, state is CallActive && state.call.isMuted ? AppTheme.errorColor : Colors.white, 'Mute', () => _bloc.add(const ToggleMuteEvent())),
                  const SizedBox(width: 24),
                  _controlBtn(state is CallActive && state.call.isSpeakerOn ? Icons.volume_up : Icons.volume_down, state is CallActive && state.call.isSpeakerOn ? AppTheme.primaryColor : Colors.white, 'Speaker', () => _bloc.add(const ToggleSpeakerEvent())),
                ]),
                const SizedBox(height: 32),
                Material(color: AppTheme.errorColor, shape: const CircleBorder(), child: InkWell(onTap: () => _bloc.add(const EndCallEvent()), customBorder: const CircleBorder(), child: const Padding(padding: EdgeInsets.all(18), child: Icon(Icons.call_end_rounded, color: Colors.white, size: 32)))),
                const SizedBox(height: 8),
                const Text('End Call', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
              ])),
            ]);
          })),
        ),
      ),
    );
  }

  Widget _controlBtn(IconData icon, Color color, String label, VoidCallback onTap) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Material(color: Colors.white.withOpacity(0.1), shape: const CircleBorder(), child: InkWell(onTap: onTap, customBorder: const CircleBorder(), child: Padding(padding: const EdgeInsets.all(14), child: Icon(icon, color: color, size: 26)))),
      const SizedBox(height: 6),
      Text(label, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
    ]);
  }

  String _callStatus(CallState state) {
    if (state is CallConnecting) return 'Connecting...';
    if (state is CallActive) { final d = state.call.duration; return '${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}'; }
    if (state is CallEnded) return 'Call ended';
    return 'Calling...';
  }

  Color _statusColor(CallState state) { if (state is CallActive) return AppTheme.successColor; if (state is CallEnded) return AppTheme.errorColor; return AppTheme.darkSubtext; }
}
