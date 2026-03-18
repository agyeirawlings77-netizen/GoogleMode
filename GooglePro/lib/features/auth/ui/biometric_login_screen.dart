import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/auth_state.dart';
import '../state/auth_event.dart';
import '../viewmodel/auth_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class BiometricLoginScreen extends StatefulWidget {
  const BiometricLoginScreen({super.key});
  @override State<BiometricLoginScreen> createState() => _BiometricLoginScreenState();
}

class _BiometricLoginScreenState extends State<BiometricLoginScreen> {
  late final AuthBloc _bloc;
  @override void initState() { super.initState(); _bloc = AuthBloc(getIt()); Future.delayed(const Duration(milliseconds: 500), () => _bloc.add(const BiometricLoginEvent())); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (ctx, state) {
          if (state is AuthAuthenticated) context.go('/dashboard');
          if (state is AuthError) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message), backgroundColor: AppTheme.errorColor)); Future.delayed(const Duration(seconds: 1), () { if (mounted) context.go('/login'); }); }
        },
        child: Scaffold(backgroundColor: AppTheme.darkBg,
          body: SafeArea(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(padding: const EdgeInsets.all(28), decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor.withOpacity(0.1)), child: const Icon(Icons.fingerprint, color: AppTheme.primaryColor, size: 72)).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(begin: 1.0, end: 1.05, duration: 1200.ms),
            const SizedBox(height: 28),
            const Text('Touch sensor to unlock', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 15)),
            const SizedBox(height: 40),
            TextButton(onPressed: () => context.go('/login'), child: const Text('Use Password Instead', style: TextStyle(color: AppTheme.primaryColor))),
          ])))),
        ),
      ),
    );
  }
}
