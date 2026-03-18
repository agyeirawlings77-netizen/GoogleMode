import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/app_lock_state.dart';
import '../state/app_lock_event.dart';
import '../viewmodel/app_lock_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';
class BiometricLockScreen extends StatefulWidget {
  const BiometricLockScreen({super.key});
  @override State<BiometricLockScreen> createState() => _BiometricLockScreenState();
}
class _BiometricLockScreenState extends State<BiometricLockScreen> {
  late final AppLockBloc _bloc;
  @override void initState() { super.initState(); _bloc = AppLockBloc(getIt()); Future.delayed(const Duration(milliseconds: 500), () => _bloc.add(const UnlockWithBiometricEvent())); }
  @override void dispose() { _bloc.close(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<AppLockBloc, AppLockState>(
        listener: (ctx, state) { if (state is AppUnlocked) context.go('/dashboard'); },
        child: Scaffold(backgroundColor: AppTheme.darkBg,
          body: SafeArea(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(padding: const EdgeInsets.all(28), decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor.withOpacity(0.1)), child: const Icon(Icons.fingerprint, color: AppTheme.primaryColor, size: 72)).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(begin: 1.0, end: 1.06, duration: 1200.ms),
            const SizedBox(height: 28),
            const Text('Touch sensor to unlock', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 15)),
            const SizedBox(height: 32),
            TextButton(onPressed: () => context.push('/app-lock/pin'), child: const Text('Use PIN instead', style: TextStyle(color: AppTheme.primaryColor))),
          ])))));
  }
}
