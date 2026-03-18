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
class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});
  @override State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}
class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  late final SettingsBloc _bloc;
  @override void initState() { super.initState(); _bloc = SettingsBloc(getIt()); _bloc.add(const LoadSettingsEvent()); }
  @override void dispose() { _bloc.close(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: Scaffold(backgroundColor: AppTheme.darkBg,
        appBar: AppBar(title: const Text('Privacy', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
        body: BlocBuilder<SettingsBloc, SettingsState>(builder: (ctx, state) {
          final s = state is SettingsLoaded ? state.settings : const AppSettings();
          return ListView(padding: const EdgeInsets.all(20), children: [
            SettingsSection(title: 'Data Collection', children: [
              SettingsTile(icon: Icons.analytics_outlined, title: 'Usage Analytics', trailing: Switch(value: s.analyticsEnabled, onChanged: (v) => _bloc.add(UpdateSettingsEvent(s.copyWith(analyticsEnabled: v))), activeColor: AppTheme.primaryColor)),
              SettingsTile(icon: Icons.bug_report_outlined, title: 'Crash Reports', trailing: Switch(value: s.crashReportingEnabled, onChanged: (v) => _bloc.add(UpdateSettingsEvent(s.copyWith(crashReportingEnabled: v))), activeColor: AppTheme.primaryColor)),
            ]),
            SettingsSection(title: 'Data', children: [
              SettingsTile(icon: Icons.delete_outline, title: 'Clear App Data', iconColor: AppTheme.errorColor, onTap: () {}),
              SettingsTile(icon: Icons.download_outlined, title: 'Export My Data', onTap: () {}),
            ]),
          ]);
        })));
  }
}
