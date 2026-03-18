import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/app_lock_state.dart';
import '../state/app_lock_event.dart';
import '../viewmodel/app_lock_bloc.dart';
import '../model/app_lock_config.dart';
import '../widget/pin_pad.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class AppLockScreen extends StatefulWidget {
  const AppLockScreen({super.key});
  @override State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  late final AppLockBloc _bloc;
  String _pin = '';
  bool _shake = false;

  @override
  void initState() {
    super.initState();
    _bloc = AppLockBloc(getIt());
    _bloc.add(const CheckLockStatusEvent());
  }

  @override void dispose() { _bloc.close(); super.dispose(); }

  void _onDigit(String d) {
    if (_pin.length >= 4) return;
    setState(() => _pin += d);
    if (_pin.length == 4) {
      Future.delayed(const Duration(milliseconds: 100), () => _bloc.add(SubmitPinEvent(_pin)));
    }
  }

  void _onDelete() { if (_pin.isNotEmpty) setState(() => _pin = _pin.substring(0, _pin.length - 1)); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<AppLockBloc, AppLockState>(
        listener: (ctx, state) {
          if (state is AppLockUnlocked) context.go('/dashboard');
          if (state is AppLockPinWrong) { setState(() { _pin = ''; _shake = true; }); Future.delayed(const Duration(milliseconds: 600), () { if (mounted) setState(() => _shake = false); }); }
        },
        child: Scaffold(
          backgroundColor: AppTheme.darkBg,
          body: SafeArea(child: Center(child: Padding(padding: const EdgeInsets.all(32),
            child: BlocBuilder<AppLockBloc, AppLockState>(builder: (ctx, state) {
              final hasBio = state is AppLockLocked && state.config.biometricEnabled;
              return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor.withOpacity(0.1)), child: const Icon(Icons.lock, color: AppTheme.primaryColor, size: 44)).animate().scale(),
                const SizedBox(height: 24),
                const Text('GooglePro', style: TextStyle(color: AppTheme.darkText, fontSize: 24, fontWeight: FontWeight.w700)).animate().fadeIn(),
                const SizedBox(height: 8),
                const Text('Enter your PIN to continue', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 14)).animate().fadeIn(delay: 100.ms),
                const SizedBox(height: 40),
                AnimatedContainer(duration: const Duration(milliseconds: 60),
                  transform: _shake ? Matrix4.translationValues(10, 0, 0) : Matrix4.identity(),
                  child: PinPad(enteredPin: _pin, onDigit: _onDigit, onDelete: _onDelete,
                    onBiometric: hasBio ? () => _bloc.add(const AuthenticateWithBiometricEvent()) : null)),
                if (state is AppLockPinWrong) Padding(padding: const EdgeInsets.only(top: 16), child: Text('Incorrect PIN (${state.attemptCount} attempt${state.attemptCount > 1 ? "s" : ""})', style: const TextStyle(color: AppTheme.errorColor, fontSize: 13))).animate().fadeIn(),
              ]);
            })))),
        ),
      ),
    );
  }
}
