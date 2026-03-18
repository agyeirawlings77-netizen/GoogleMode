import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/settings_state.dart';
import '../state/settings_event.dart';
import '../viewmodel/settings_bloc.dart';
import '../model/app_settings.dart';
import '../widget/settings_section.dart';
import '../widget/settings_tile.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsBloc _bloc;
  @override void initState() { super.initState(); _bloc = SettingsBloc(getIt()); _bloc.add(const LoadSettingsEvent()); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(title: const Text('Settings', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
        body: BlocBuilder<SettingsBloc, SettingsState>(builder: (ctx, state) {
          if (state is SettingsLoading) return const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor));
          final s = state is SettingsLoaded ? state.settings : const AppSettings();
          return ListView(padding: const EdgeInsets.all(20), children: [
            // Profile header
            _profileCard(),
            const SizedBox(height: 24),

            SettingsSection(title: 'Connection', children: [
              SettingsTile(icon: Icons.autorenew, title: 'Auto-Connect Trusted Devices', subtitle: s.autoConnectEnabled ? 'Enabled' : 'Disabled', trailing: Switch(value: s.autoConnectEnabled, onChanged: (v) => _update(s.copyWith(autoConnectEnabled: v)), activeColor: AppTheme.primaryColor)),
              SettingsTile(icon: Icons.timer_outlined, title: 'Connection Timeout', subtitle: '${s.connectionTimeoutSeconds}s', onTap: () {}),
              SettingsTile(icon: Icons.speed, title: 'Default FPS', subtitle: '${s.defaultFps} fps', onTap: () {}),
              SettingsTile(icon: Icons.wifi, title: 'Default Bitrate', subtitle: '${s.defaultBitrateKbps} kbps', onTap: () {}),
              SettingsTile(icon: Icons.bar_chart, title: 'Show Connection Stats', trailing: Switch(value: s.showConnectionStats, onChanged: (v) => _update(s.copyWith(showConnectionStats: v)), activeColor: AppTheme.primaryColor)),
            ]).animate().fadeIn(delay: 100.ms),

            SettingsSection(title: 'Notifications', children: [
              SettingsTile(icon: Icons.notifications_outlined, title: 'Push Notifications', trailing: Switch(value: s.notificationsEnabled, onChanged: (v) => _update(s.copyWith(notificationsEnabled: v)), activeColor: AppTheme.primaryColor)),
              SettingsTile(icon: Icons.volume_up_outlined, title: 'Sound', trailing: Switch(value: s.soundEnabled, onChanged: (v) => _update(s.copyWith(soundEnabled: v)), activeColor: AppTheme.primaryColor)),
              SettingsTile(icon: Icons.vibration, title: 'Vibration', trailing: Switch(value: s.vibrationEnabled, onChanged: (v) => _update(s.copyWith(vibrationEnabled: v)), activeColor: AppTheme.primaryColor)),
            ]).animate().fadeIn(delay: 200.ms),

            SettingsSection(title: 'Appearance', children: [
              SettingsTile(icon: Icons.palette_outlined, title: 'Theme', subtitle: 'Dark', onTap: () => context.push('/theme-settings')),
              SettingsTile(icon: Icons.language, title: 'Language', subtitle: _langName(s.language), onTap: () => context.push('/language-settings')),
              SettingsTile(icon: Icons.brightness_4_outlined, title: 'Auto Brightness', onTap: () {}),
            ]).animate().fadeIn(delay: 300.ms),

            SettingsSection(title: 'Security', children: [
              SettingsTile(icon: Icons.lock_outlined, title: 'App Lock', iconColor: Colors.orange, onTap: () => context.push('/app-lock/settings')),
              SettingsTile(icon: Icons.security_outlined, title: 'Security Settings', iconColor: Colors.red, onTap: () => context.push('/security')),
              SettingsTile(icon: Icons.fingerprint, title: 'Biometric Login', onTap: () {}),
            ]).animate().fadeIn(delay: 400.ms),

            SettingsSection(title: 'Privacy', children: [
              SettingsTile(icon: Icons.analytics_outlined, title: 'Usage Analytics', trailing: Switch(value: s.analyticsEnabled, onChanged: (v) => _update(s.copyWith(analyticsEnabled: v)), activeColor: AppTheme.primaryColor)),
              SettingsTile(icon: Icons.bug_report_outlined, title: 'Crash Reports', trailing: Switch(value: s.crashReportingEnabled, onChanged: (v) => _update(s.copyWith(crashReportingEnabled: v)), activeColor: AppTheme.primaryColor)),
            ]).animate().fadeIn(delay: 500.ms),

            SettingsSection(title: 'About', children: [
              SettingsTile(icon: Icons.info_outlined, title: 'App Version', subtitle: '1.0.0 (build 1)'),
              SettingsTile(icon: Icons.policy_outlined, title: 'Privacy Policy', onTap: () {}),
              SettingsTile(icon: Icons.description_outlined, title: 'Terms of Service', onTap: () => context.push('/terms')),
              SettingsTile(icon: Icons.help_outline, title: 'Help & Support', onTap: () {}),
              SettingsTile(icon: Icons.star_outline, title: 'Rate App', onTap: () {}),
            ]).animate().fadeIn(delay: 600.ms),

            Padding(padding: const EdgeInsets.only(top: 8, bottom: 32),
              child: TextButton.icon(
                onPressed: () async { await FirebaseAuth.instance.signOut(); context.go('/login'); },
                icon: const Icon(Icons.logout, color: AppTheme.errorColor),
                label: const Text('Sign Out', style: TextStyle(color: AppTheme.errorColor, fontSize: 15, fontWeight: FontWeight.w600)),
              )).animate().fadeIn(delay: 700.ms),
          ]);
        }),
      ),
    );
  }

  Widget _profileCard() {
    final user = FirebaseAuth.instance.currentUser;
    return Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2))),
      child: Row(children: [
        CircleAvatar(radius: 28, backgroundColor: AppTheme.primaryColor.withOpacity(0.15),
          backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
          child: user?.photoURL == null ? Text(user?.displayName?.isNotEmpty == true ? user!.displayName![0].toUpperCase() : 'G', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 22, fontWeight: FontWeight.w700)) : null),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(user?.displayName ?? 'User', style: const TextStyle(color: AppTheme.darkText, fontSize: 16, fontWeight: FontWeight.w700)),
          Text(user?.email ?? '', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
        ])),
        IconButton(icon: const Icon(Icons.edit_outlined, color: AppTheme.primaryColor), onPressed: () => context.push('/profile')),
      ])).animate().fadeIn();
  }

  void _update(AppSettings s) => _bloc.add(UpdateSettingsEvent(s));
  String _langName(String code) { switch (code) { case 'fr': return 'Français'; case 'es': return 'Español'; case 'ar': return 'العربية'; case 'pt': return 'Português'; default: return 'English'; } }
}
