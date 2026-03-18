import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/app_lock_state.dart';
import '../state/app_lock_event.dart';
import '../viewmodel/app_lock_bloc.dart';
import '../model/app_lock_config.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class AppLockSettingsScreen extends StatefulWidget {
  const AppLockSettingsScreen({super.key});
  @override State<AppLockSettingsScreen> createState() => _AppLockSettingsScreenState();
}

class _AppLockSettingsScreenState extends State<AppLockSettingsScreen> {
  late final AppLockBloc _bloc;
  @override void initState() { super.initState(); _bloc = AppLockBloc(getIt()); _bloc.add(const LoadAppLockConfigEvent()); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(title: const Text('App Lock', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
        body: BlocBuilder<AppLockBloc, AppLockState>(builder: (ctx, state) {
          final config = state is AppLockConfigLoaded ? state.config : const AppLockConfig();
          return ListView(padding: const EdgeInsets.all(20), children: [
            // Lock status card
            Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(20), border: Border.all(color: config.isEnabled ? AppTheme.primaryColor.withOpacity(0.3) : AppTheme.darkBorder)),
              child: Row(children: [
                Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: (config.isEnabled ? AppTheme.primaryColor : AppTheme.darkSubtext).withOpacity(0.1), shape: BoxShape.circle), child: Icon(config.isEnabled ? Icons.lock : Icons.lock_open, color: config.isEnabled ? AppTheme.primaryColor : AppTheme.darkSubtext, size: 28)),
                const SizedBox(width: 16),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(config.isEnabled ? 'Lock Enabled' : 'Lock Disabled', style: TextStyle(color: config.isEnabled ? AppTheme.primaryColor : AppTheme.darkText, fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(config.isEnabled ? 'App locked with ${config.lockType.name}' : 'Protect your app with a lock', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
                ])),
              ])).animate().fadeIn(),

            const SizedBox(height: 24),
            _option(Icons.pin, 'Set PIN Lock', () => context.push('/app-lock/setup')),
            _option(Icons.fingerprint, 'Use Biometric', () {}),
            if (config.isEnabled) _option(Icons.no_encryption_outlined, 'Remove Lock', () => _bloc.add(const RemoveLockEvent()), color: AppTheme.errorColor),
          ]);
        }),
      ),
    );
  }

  Widget _option(IconData icon, String label, VoidCallback onTap, {Color color = AppTheme.darkText}) {
    return Container(margin: const EdgeInsets.only(bottom: 10),
      child: Material(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14),
        child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(14),
          child: Padding(padding: const EdgeInsets.all(16),
            child: Row(children: [
              Icon(icon, color: color == AppTheme.darkText ? AppTheme.primaryColor : color, size: 22),
              const SizedBox(width: 12),
              Text(label, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w500)),
              const Spacer(),
              const Icon(Icons.chevron_right, color: AppTheme.darkSubtext),
            ])))));
  }
}
