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
class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});
  @override State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}
class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  late final SettingsBloc _bloc;
  @override void initState() { super.initState(); _bloc = SettingsBloc(getIt()); _bloc.add(const LoadSettingsEvent()); }
  @override void dispose() { _bloc.close(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: Scaffold(backgroundColor: AppTheme.darkBg,
        appBar: AppBar(title: const Text('Notifications', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
        body: BlocBuilder<SettingsBloc, SettingsState>(builder: (ctx, state) {
          final s = state is SettingsLoaded ? state.settings : const AppSettings();
          return ListView(padding: const EdgeInsets.all(20), children: [
            SettingsSection(title: 'General', children: [
              SettingsTile(icon: Icons.notifications_outlined, title: 'All Notifications', trailing: Switch(value: s.notificationsEnabled, onChanged: (v) => _bloc.add(UpdateSettingsEvent(s.copyWith(notificationsEnabled: v))), activeColor: AppTheme.primaryColor)),
              SettingsTile(icon: Icons.volume_up_outlined, title: 'Sound', trailing: Switch(value: s.soundEnabled, onChanged: (v) => _bloc.add(UpdateSettingsEvent(s.copyWith(soundEnabled: v))), activeColor: AppTheme.primaryColor)),
              SettingsTile(icon: Icons.vibration, title: 'Vibration', trailing: Switch(value: s.vibrationEnabled, onChanged: (v) => _bloc.add(UpdateSettingsEvent(s.copyWith(vibrationEnabled: v))), activeColor: AppTheme.primaryColor)),
            ]),
          ]);
        })));
  }
}
