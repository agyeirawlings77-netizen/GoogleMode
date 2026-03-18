import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/app_lock_state.dart';
import '../state/app_lock_event.dart';
import '../viewmodel/app_lock_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class PinLockScreen extends StatefulWidget {
  final bool isSetup;
  const PinLockScreen({super.key, this.isSetup = false});
  @override State<PinLockScreen> createState() => _PinLockScreenState();
}

class _PinLockScreenState extends State<PinLockScreen> {
  late final AppLockBloc _bloc;
  String _pin = '';
  String _confirmPin = '';
  bool _confirming = false;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _bloc = AppLockBloc(getIt());
    if (!widget.isSetup) _bloc.add(const LoadAppLockConfigEvent());
  }

  @override void dispose() { _bloc.close(); super.dispose(); }

  void _onDigit(String d) {
    if (_pin.length >= 6) return;
    setState(() { _pin += d; _errorMsg = null; });
    if (_pin.length == 6) {
      if (widget.isSetup) {
        if (!_confirming) { setState(() { _confirmPin = _pin; _pin = ''; _confirming = true; }); }
        else if (_pin == _confirmPin) { _bloc.add(SetPinEvent(_pin)); }
        else { setState(() { _pin = ''; _confirming = false; _errorMsg = 'PINs do not match'; }); }
      } else {
        _bloc.add(UnlockWithPinEvent(_pin));
        setState(() => _pin = '');
      }
    }
  }

  void _onDelete() { if (_pin.isNotEmpty) setState(() => _pin = _pin.substring(0, _pin.length - 1)); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<AppLockBloc, AppLockState>(
        listener: (ctx, state) {
          if (state is AppUnlocked) context.go('/dashboard');
          if (state is AppLockConfigLoaded && widget.isSetup) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN set successfully'), backgroundColor: AppTheme.successColor)); context.pop(); }
          if (state is AppLocked && state.failedAttempts > 0) setState(() { _errorMsg = 'Wrong PIN (${state.failedAttempts} attempt${state.failedAttempts > 1 ? "s" : ""})'; });
        },
        child: Scaffold(
          backgroundColor: AppTheme.darkBg,
          body: SafeArea(child: Padding(padding: const EdgeInsets.all(24), child: Column(children: [
            if (widget.isSetup) Align(alignment: Alignment.topLeft, child: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
            const Spacer(),
            const Icon(Icons.lock_rounded, color: AppTheme.primaryColor, size: 48).animate().scale(),
            const SizedBox(height: 20),
            Text(_confirming ? 'Confirm PIN' : widget.isSetup ? 'Create PIN' : 'Enter PIN', style: const TextStyle(color: AppTheme.darkText, fontSize: 22, fontWeight: FontWeight.w700)).animate().fadeIn(),
            const SizedBox(height: 8),
            if (_errorMsg != null) Text(_errorMsg!, style: const TextStyle(color: AppTheme.errorColor, fontSize: 13)).animate().shakeX(),
            const SizedBox(height: 24),
            // Dots
            Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(6, (i) =>
              Container(width: 14, height: 14, margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(shape: BoxShape.circle, color: i < _pin.length ? AppTheme.primaryColor : AppTheme.darkBorder)))),
            const SizedBox(height: 40),
            // Number pad
            GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.4),
              itemCount: 12,
              itemBuilder: (ctx, i) {
                if (i == 9) return const SizedBox.shrink();
                if (i == 11) return _keyBtn(Icons.backspace_outlined, null, _onDelete);
                final digit = i == 10 ? '0' : '${i + 1}';
                return _keyBtn(null, digit, () => _onDigit(digit));
              }),
            const Spacer(),
            if (!widget.isSetup) TextButton(onPressed: () => _bloc.add(const UnlockWithBiometricEvent()), child: const Text('Use Biometric', style: TextStyle(color: AppTheme.primaryColor))),
          ]))),
        ),
      ),
    );
  }

  Widget _keyBtn(IconData? icon, String? label, VoidCallback onTap) {
    return Material(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14),
      child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(14),
        child: Center(child: icon != null ? Icon(icon, color: AppTheme.darkText, size: 22) : Text(label!, style: const TextStyle(color: AppTheme.darkText, fontSize: 24, fontWeight: FontWeight.w600)))));
  }
}
