import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/app_lock_state.dart';
import '../state/app_lock_event.dart';
import '../viewmodel/app_lock_bloc.dart';
import '../widget/pin_pad.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class SetupPinScreen extends StatefulWidget {
  const SetupPinScreen({super.key});
  @override State<SetupPinScreen> createState() => _SetupPinScreenState();
}

class _SetupPinScreenState extends State<SetupPinScreen> {
  late final AppLockBloc _bloc;
  String _pin = '';
  String _confirmPin = '';
  bool _confirming = false;

  @override void initState() { super.initState(); _bloc = AppLockBloc(getIt()); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  void _onDigit(String d) {
    if (!_confirming) {
      if (_pin.length >= 4) return;
      setState(() => _pin += d);
      if (_pin.length == 4) Future.delayed(const Duration(milliseconds: 200), () => setState(() => _confirming = true));
    } else {
      if (_confirmPin.length >= 4) return;
      setState(() => _confirmPin += d);
      if (_confirmPin.length == 4) {
        if (_confirmPin == _pin) _bloc.add(SetupPinEvent(_pin));
        else { setState(() { _pin = ''; _confirmPin = ''; _confirming = false; }); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PINs do not match'), backgroundColor: AppTheme.errorColor)); }
      }
    }
  }

  void _onDelete() {
    if (!_confirming) { if (_pin.isNotEmpty) setState(() => _pin = _pin.substring(0, _pin.length - 1)); }
    else { if (_confirmPin.isNotEmpty) setState(() => _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1)); }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<AppLockBloc, AppLockState>(
        listener: (ctx, state) { if (state is AppLockSetup) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PIN set up successfully'), backgroundColor: AppTheme.successColor)); context.pop(); } },
        child: Scaffold(backgroundColor: AppTheme.darkBg,
          appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
          body: SafeArea(child: Padding(padding: const EdgeInsets.all(32), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.lock_outline, color: AppTheme.primaryColor, size: 48).animate().scale(),
            const SizedBox(height: 24),
            Text(_confirming ? 'Confirm your PIN' : 'Create a PIN', style: const TextStyle(color: AppTheme.darkText, fontSize: 22, fontWeight: FontWeight.w700)).animate().fadeIn(),
            const SizedBox(height: 8),
            Text(_confirming ? 'Enter the same PIN again' : 'This PIN will lock GooglePro', style: const TextStyle(color: AppTheme.darkSubtext)).animate().fadeIn(delay: 100.ms),
            const SizedBox(height: 40),
            PinPad(enteredPin: _confirming ? _confirmPin : _pin, onDigit: _onDigit, onDelete: _onDelete),
          ])))),
        ),
      ),
    );
  }
}
