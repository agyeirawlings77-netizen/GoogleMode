import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/remote_control_state.dart';
import '../state/remote_control_event.dart';
import '../viewmodel/remote_control_bloc.dart';
import '../model/input_event.dart';
import '../widget/touch_overlay.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class RemoteControlScreen extends StatefulWidget {
  final String deviceId;
  const RemoteControlScreen({super.key, required this.deviceId});
  @override State<RemoteControlScreen> createState() => _RemoteControlScreenState();
}

class _RemoteControlScreenState extends State<RemoteControlScreen> {
  late final RemoteControlBloc _bloc;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _bloc = RemoteControlBloc(getIt())..add(EnableRemoteControlEvent(widget.deviceId));
  }
  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: Scaffold(backgroundColor: Colors.black,
        body: GestureDetector(onTap: () => setState(() => _showControls = !_showControls),
          child: Stack(children: [
            // Remote screen placeholder
            Container(color: const Color(0xFF111111), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.touch_app_rounded, color: AppTheme.primaryColor, size: 64).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0), duration: 1500.ms), const SizedBox(height: 12), const Text('Touch to control remote screen', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 13))]))),

            // Touch input layer
            TouchOverlay(remoteWidth: 1080, remoteHeight: 1920,
              onTap: (x, y) => _bloc.add(SendInputEventEvent(InputEvent.tap(x, y))),
              onSwipe: (x1, y1, x2, y2) => _bloc.add(SendInputEventEvent(InputEvent.swipe(x1, y1, x2, y2)))),

            // Top bar
            if (_showControls) SafeArea(child: Container(color: Colors.black.withOpacity(0.6), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), child: Row(children: [
              IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18), onPressed: () { _bloc.add(const DisableRemoteControlEvent()); context.pop(); }),
              const Text('Remote Control', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.keyboard_outlined, color: Colors.white), onPressed: () => _showKeyboard(context)),
            ]))),
          ]),
        ),
      ),
    );
  }

  void _showKeyboard(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: AppTheme.darkCard, builder: (_) {
      final ctrl = TextEditingController();
      return Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 40, height: 4, margin: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppTheme.darkBorder, borderRadius: BorderRadius.circular(2))),
        Padding(padding: const EdgeInsets.all(16), child: TextField(controller: ctrl, autofocus: true, style: const TextStyle(color: AppTheme.darkText), decoration: InputDecoration(hintText: 'Type text to send...', hintStyle: const TextStyle(color: AppTheme.darkSubtext), filled: true, fillColor: AppTheme.darkBorder, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none), suffixIcon: IconButton(icon: const Icon(Icons.send, color: AppTheme.primaryColor), onPressed: () { if (ctrl.text.isNotEmpty) { _bloc.add(SendInputEventEvent(InputEvent.typeText(ctrl.text))); Navigator.pop(context); } })))),
      ]));
    });
  }
}
