import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/parental_state.dart';
import '../state/parental_event.dart';
import '../viewmodel/parental_bloc.dart';
import '../widget/screen_time_chart.dart';
import '../widget/app_rule_tile.dart';
import '../widget/screen_limit_slider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class ParentalControlsScreen extends StatefulWidget {
  final String deviceId;
  final String deviceName;
  const ParentalControlsScreen({super.key, required this.deviceId, required this.deviceName});
  @override State<ParentalControlsScreen> createState() => _ParentalControlsScreenState();
}

class _ParentalControlsScreenState extends State<ParentalControlsScreen> with SingleTickerProviderStateMixin {
  late final ParentalBloc _bloc;
  late TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
    _bloc = ParentalBloc(getIt());
    _bloc.add(LoadParentalDataEvent(widget.deviceId));
  }

  @override void dispose() { _tabs.dispose(); _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Parental Controls', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700, fontSize: 16)),
            Text(widget.deviceName, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
          ]),
          backgroundColor: AppTheme.darkSurface, elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop()),
          actions: [
            BlocBuilder<ParentalBloc, ParentalState>(builder: (ctx, state) =>
              IconButton(icon: const Icon(Icons.lock_outlined, color: AppTheme.errorColor),
                onPressed: () { _bloc.add(LockDeviceEvent(widget.deviceId)); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lock command sent'), backgroundColor: AppTheme.successColor)); },
                tooltip: 'Lock device')),
          ],
          bottom: TabBar(controller: _tabs, indicatorColor: AppTheme.primaryColor, labelColor: AppTheme.primaryColor, unselectedLabelColor: AppTheme.darkSubtext, labelStyle: const TextStyle(fontSize: 12), tabs: const [Tab(text: 'Screen Time'), Tab(text: 'App Rules'), Tab(text: 'Settings')]),
        ),
        body: BlocBuilder<ParentalBloc, ParentalState>(builder: (ctx, state) {
          if (state is ParentalLoading) return const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor));
          if (state is ParentalLoaded) return TabBarView(controller: _tabs, children: [_buildScreenTime(state), _buildRules(state), _buildSettings(state)]);
          return const SizedBox.shrink();
        }),
      ),
    );
  }

  Widget _buildScreenTime(ParentalLoaded state) {
    final st = state.todayScreenTime;
    return ListView(padding: const EdgeInsets.all(16), children: [
      // Today summary
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.darkBorder)),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Today', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 13)),
            Text(st?.formattedTotal ?? '0m', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 22, fontWeight: FontWeight.w800)),
          ]),
          if (state.profile != null) ...[
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: st != null ? (st.totalMinutes / state.profile!.dailyScreenLimitMinutes).clamp(0.0, 1.0) : 0,
              backgroundColor: AppTheme.darkBorder,
              valueColor: AlwaysStoppedAnimation<Color>(st != null && st.totalMinutes >= state.profile!.dailyScreenLimitMinutes ? AppTheme.errorColor : AppTheme.primaryColor),
              minHeight: 6, borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 4),
            Text('Limit: ${state.profile!.dailyScreenLimitMinutes ~/ 60}h ${state.profile!.dailyScreenLimitMinutes % 60}m', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
          ],
        ])).animate().fadeIn(),

      const SizedBox(height: 16),
      const Text('This Week', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1)),
      const SizedBox(height: 8),
      ScreenTimeChart(weekData: []).animate().fadeIn(delay: 100.ms),

      if (st != null && st.appUsageMinutes.isNotEmpty) ...[
        const SizedBox(height: 20),
        const Text('Top Apps Today', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1)),
        const SizedBox(height: 8),
        ...st.appUsageMinutes.entries.take(5).map((e) => ListTile(
          leading: const Icon(Icons.apps, color: AppTheme.primaryColor),
          title: Text(e.key, style: const TextStyle(color: AppTheme.darkText)),
          trailing: Text('${e.value}m', style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w600)),
        )),
      ],
    ]);
  }

  Widget _buildRules(ParentalLoaded state) {
    return ListView(padding: const EdgeInsets.all(16), children: [
      ...state.rules.map((r) => AppRuleTile(rule: r, onToggle: (v) => _bloc.add(ToggleRuleEvent(r.ruleId, v)), onDelete: () => _bloc.add(RemoveRuleEvent(r.ruleId)))),
      if (state.rules.isEmpty) _emptyRules(),
    ]);
  }

  Widget _buildSettings(ParentalLoaded state) {
    final profile = state.profile;
    return ListView(padding: const EdgeInsets.all(16), children: [
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.darkBorder)),
        child: ScreenLimitSlider(initialMinutes: profile?.dailyScreenLimitMinutes ?? 120, onChanged: (v) => _bloc.add(UpdateScreenLimitEvent(v)))),
      const SizedBox(height: 16),
      ...[
        _settingTile('Content Filter', Icons.filter_alt_outlined, profile?.contentFilterEnabled ?? true, (v) { if (profile != null) { final updated = profile.copyWith(contentFilterEnabled: v); _bloc.add(SaveProfileEvent(updated)); } }),
        _settingTile('Web Filter', Icons.language_outlined, profile?.webFilterEnabled ?? true, (v) { if (profile != null) { final updated = profile.copyWith(webFilterEnabled: v); _bloc.add(SaveProfileEvent(updated)); } }),
        _settingTile('Location Sharing', Icons.location_on_outlined, profile?.locationSharingEnabled ?? true, (v) { if (profile != null) { final updated = profile.copyWith(locationSharingEnabled: v); _bloc.add(SaveProfileEvent(updated)); } }),
      ],
    ]);
  }

  Widget _settingTile(String label, IconData icon, bool value, ValueChanged<bool> onChanged) =>
    Container(margin: const EdgeInsets.only(bottom: 8), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.darkBorder)),
      child: SwitchListTile(title: Text(label, style: const TextStyle(color: AppTheme.darkText, fontSize: 14)), secondary: Icon(icon, color: AppTheme.primaryColor, size: 20), value: value, onChanged: onChanged, activeColor: AppTheme.primaryColor));

  Widget _emptyRules() => Center(child: Padding(padding: const EdgeInsets.all(32), child: Column(children: [
    const Icon(Icons.rule_folder_outlined, color: AppTheme.darkSubtext, size: 48),
    const SizedBox(height: 12),
    const Text('No app rules set', style: TextStyle(color: AppTheme.darkSubtext)),
  ])));
}
