import 'package:flutter/material.dart';
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

class ConnectionSettingsScreen extends StatefulWidget {
  const ConnectionSettingsScreen({super.key});
  @override State<ConnectionSettingsScreen> createState() => _ConnectionSettingsScreenState();
}

class _ConnectionSettingsScreenState extends State<ConnectionSettingsScreen> {
  late final SettingsBloc _bloc;
  @override void initState() { super.initState(); _bloc = SettingsBloc(getIt()); _bloc.add(const LoadSettingsEvent()); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(title: const Text('Connection', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
        body: BlocBuilder<SettingsBloc, SettingsState>(builder: (ctx, state) {
          final s = state is SettingsLoaded ? state.settings : const AppSettings();
          return ListView(padding: const EdgeInsets.all(20), children: [
            SettingsSection(title: 'Performance', children: [
              SettingsTile(icon: Icons.speed, title: 'Default FPS', subtitle: '${s.defaultFps} fps', onTap: () => _showFpsPicker(s)),
              SettingsTile(icon: Icons.wifi, title: 'Default Bitrate', subtitle: '${s.defaultBitrateKbps} kbps', onTap: () {}),
              SettingsTile(icon: Icons.timer_outlined, title: 'Timeout', subtitle: '${s.connectionTimeoutSeconds}s', onTap: () {}),
            ]),
            SettingsSection(title: 'Auto Connect', children: [
              SettingsTile(icon: Icons.autorenew, title: 'Auto-Connect Trusted', trailing: Switch(value: s.autoConnectEnabled, onChanged: (v) => _bloc.add(UpdateSettingsEvent(s.copyWith(autoConnectEnabled: v))), activeColor: AppTheme.primaryColor)),
              SettingsTile(icon: Icons.sync, title: 'Background Sync', trailing: Switch(value: s.backgroundSyncEnabled, onChanged: (v) => _bloc.add(UpdateSettingsEvent(s.copyWith(backgroundSyncEnabled: v))), activeColor: AppTheme.primaryColor)),
            ]),
            SettingsSection(title: 'Display', children: [
              SettingsTile(icon: Icons.bar_chart, title: 'Show Stats Overlay', trailing: Switch(value: s.showConnectionStats, onChanged: (v) => _bloc.add(UpdateSettingsEvent(s.copyWith(showConnectionStats: v))), activeColor: AppTheme.primaryColor)),
              SettingsTile(icon: Icons.screen_lock_rotation, title: 'Keep Screen On', trailing: Switch(value: s.keepScreenOn, onChanged: (v) => _bloc.add(UpdateSettingsEvent(s.copyWith(keepScreenOn: v))), activeColor: AppTheme.primaryColor)),
            ]),
          ]);
        }),
      ),
    );
  }

  void _showFpsPicker(AppSettings s) => showModalBottomSheet(context: context, backgroundColor: AppTheme.darkCard, builder: (_) => Padding(padding: const EdgeInsets.all(20), child: Column(mainAxisSize: MainAxisSize.min, children: [
    const Text('Select FPS', style: TextStyle(color: AppTheme.darkText, fontSize: 16, fontWeight: FontWeight.w700)),
    const SizedBox(height: 16),
    ...[5, 10, 15, 20, 24, 30].map((fps) => ListTile(title: Text('$fps FPS', style: const TextStyle(color: AppTheme.darkText)), trailing: s.defaultFps == fps ? const Icon(Icons.check, color: AppTheme.primaryColor) : null, onTap: () { _bloc.add(UpdateSettingsEvent(s.copyWith(defaultFps: fps))); Navigator.pop(context); })),
  ])));
}
