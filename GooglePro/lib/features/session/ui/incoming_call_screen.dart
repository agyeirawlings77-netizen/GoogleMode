import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/session_state.dart';
import '../state/session_event.dart';
import '../viewmodel/session_bloc.dart';
import '../../../core/theme/app_theme.dart';

class IncomingCallScreen extends StatelessWidget {
  final String fromDeviceName;
  final SessionBloc bloc;
  const IncomingCallScreen({super.key, required this.fromDeviceName, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: bloc,
      child: BlocListener<SessionBloc, SessionState>(
        listener: (ctx, state) { if (state is SessionActive) context.go('/screen-viewer/${(state).session.hostUserId}'); if (state is SessionIdle) context.pop(); },
        child: Scaffold(
          backgroundColor: AppTheme.darkBg,
          body: SafeArea(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(padding: const EdgeInsets.all(28), decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor.withOpacity(0.15)),
              child: const Icon(Icons.screen_share_rounded, color: AppTheme.primaryColor, size: 64))
              .animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(begin: 1.0, end: 1.08, duration: 1000.ms),
            const SizedBox(height: 32),
            const Text('Incoming Screen Share', style: TextStyle(color: AppTheme.darkText, fontSize: 22, fontWeight: FontWeight.w700)).animate().fadeIn(),
            const SizedBox(height: 8),
            Text(fromDeviceName, style: const TextStyle(color: AppTheme.primaryColor, fontSize: 18, fontWeight: FontWeight.w600)).animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 8),
            const Text('wants to share their screen with you', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 14)).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 56),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(onTap: () => bloc.add(const RejectSessionEvent()),
                child: Container(width: 68, height: 68, decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.errorColor.withOpacity(0.15), border: Border.all(color: AppTheme.errorColor.withOpacity(0.4))),
                  child: const Icon(Icons.call_end, color: AppTheme.errorColor, size: 32))).animate().fadeIn(delay: 400.ms).scale(),
              const SizedBox(width: 48),
              GestureDetector(onTap: () => bloc.add(const AcceptSessionEvent()),
                child: Container(width: 68, height: 68, decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.successColor.withOpacity(0.15), border: Border.all(color: AppTheme.successColor.withOpacity(0.4))),
                  child: const Icon(Icons.call, color: AppTheme.successColor, size: 32))).animate().fadeIn(delay: 500.ms).scale(),
            ]),
            const SizedBox(height: 24),
            const Text('Accept', style: TextStyle(color: AppTheme.successColor, fontSize: 12)),
          ]))),
        ),
      ),
    );
  }
}
