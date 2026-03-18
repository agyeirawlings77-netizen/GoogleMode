import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/security_state.dart';
import '../state/security_event.dart';
import '../viewmodel/security_bloc.dart';
import '../model/security_alert.dart';
import '../model/security_settings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});
  @override State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  late final SecurityBloc _bloc;
  @override void initState() { super.initState(); _bloc = SecurityBloc(getIt()); _bloc.add(const LoadSecurityDataEvent()); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(title: const Text('Security', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop()),
          actions: [IconButton(icon: const Icon(Icons.security, color: AppTheme.primaryColor), onPressed: () => _bloc.add(const RunSecurityScanEvent()), tooltip: 'Run scan')]),
        body: BlocBuilder<SecurityBloc, SecurityState>(builder: (ctx, state) {
          if (state is SecurityLoading) return const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor));
          if (state is SecurityLoaded) return _buildLoaded(state);
          return const SizedBox.shrink();
        }),
      ),
    );
  }

  Widget _buildLoaded(SecurityLoaded state) {
    final score = state.scanResult?['score'] as int? ?? 85;
    return ListView(padding: const EdgeInsets.all(16), children: [
      // Security score
      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.darkBorder)),
        child: Row(children: [
          Stack(alignment: Alignment.center, children: [
            SizedBox(width: 72, height: 72, child: CircularProgressIndicator(value: score / 100, strokeWidth: 6, backgroundColor: AppTheme.darkBorder, valueColor: AlwaysStoppedAnimation<Color>(_scoreColor(score)))),
            Text('$score', style: TextStyle(color: _scoreColor(score), fontSize: 22, fontWeight: FontWeight.w800)),
          ]),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Security Score', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700, fontSize: 16)),
            const SizedBox(height: 4),
            Text(_scoreLabel(score), style: TextStyle(color: _scoreColor(score), fontSize: 13)),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: () => _bloc.add(const RunSecurityScanEvent()),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, minimumSize: const Size(120, 32), padding: const EdgeInsets.symmetric(horizontal: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              child: const Text('Re-scan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700))),
          ])),
        ])).animate().fadeIn(),

      const SizedBox(height: 20),
      const Text('Settings', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1)),
      const SizedBox(height: 8),
      ..._buildSettings(state.settings),

      if (state.alerts.isNotEmpty) ...[
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Alerts', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 1)),
          Text('${state.alerts.where((a) => !a.isRead).length} unread', style: const TextStyle(color: AppTheme.primaryColor, fontSize: 12)),
        ]),
        const SizedBox(height: 8),
        ...state.alerts.take(5).map((a) => _AlertTile(alert: a, onRead: () => _bloc.add(MarkAlertReadEvent(a.alertId)))),
      ],
    ]);
  }

  List<Widget> _buildSettings(SecuritySettings s) => [
    _toggle('Two-Factor Auth', Icons.verified_user_outlined, s.twoFactorEnabled, (v) => _bloc.add(UpdateSettingsEvent({'twoFactorEnabled': v}))),
    _toggle('Login Alerts', Icons.notifications_outlined, s.loginAlerts, (v) => _bloc.add(UpdateSettingsEvent({'loginAlerts': v}))),
    _toggle('Unknown Device Alerts', Icons.devices_outlined, s.unknownDeviceAlerts, (v) => _bloc.add(UpdateSettingsEvent({'unknownDeviceAlerts': v}))),
    _toggle('Data Encryption', Icons.lock_outlined, s.encryptionEnabled, (v) => _bloc.add(UpdateSettingsEvent({'encryptionEnabled': v}))),
    _toggle('Block Screenshots', Icons.screenshot_monitor, s.screenshotBlocked, (v) => _bloc.add(UpdateSettingsEvent({'screenshotBlocked': v}))),
    _tile('App Lock & PIN', Icons.pin_outlined, () => context.push('/app-lock-setup')),
  ];

  Widget _toggle(String label, IconData icon, bool val, ValueChanged<bool> onChanged) =>
    Container(margin: const EdgeInsets.only(bottom: 8), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.darkBorder)),
      child: SwitchListTile(title: Text(label, style: const TextStyle(color: AppTheme.darkText, fontSize: 14)), secondary: Icon(icon, color: AppTheme.primaryColor, size: 20), value: val, onChanged: onChanged, activeColor: AppTheme.primaryColor));

  Widget _tile(String label, IconData icon, VoidCallback onTap) =>
    Container(margin: const EdgeInsets.only(bottom: 8), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.darkBorder)),
      child: ListTile(leading: Icon(icon, color: AppTheme.primaryColor, size: 20), title: Text(label, style: const TextStyle(color: AppTheme.darkText, fontSize: 14)), trailing: const Icon(Icons.chevron_right, color: AppTheme.darkSubtext), onTap: onTap));

  Color _scoreColor(int s) => s >= 80 ? AppTheme.successColor : s >= 60 ? Colors.orange : AppTheme.errorColor;
  String _scoreLabel(int s) => s >= 80 ? 'Good — Keep it up' : s >= 60 ? 'Fair — Some issues detected' : 'Poor — Action required';
}

class _AlertTile extends StatelessWidget {
  final SecurityAlert alert;
  final VoidCallback onRead;
  const _AlertTile({required this.alert, required this.onRead});
  @override
  Widget build(BuildContext context) {
    final c = _sevColor(alert.severity);
    return GestureDetector(onTap: onRead, child: Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: alert.isRead ? AppTheme.darkBorder : c.withOpacity(0.4))),
      child: Row(children: [
        Container(width: 36, height: 36, decoration: BoxDecoration(color: c.withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: Icon(Icons.warning_amber_rounded, color: c, size: 18)),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(alert.title, style: TextStyle(color: alert.isRead ? AppTheme.darkSubtext : AppTheme.darkText, fontWeight: alert.isRead ? FontWeight.w400 : FontWeight.w600, fontSize: 13)),
          Text(alert.description, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis),
        ])),
        if (!alert.isRead) Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: c)),
      ])));
  }
  Color _sevColor(AlertSeverity s) { switch (s) { case AlertSeverity.critical: return AppTheme.errorColor; case AlertSeverity.high: return Colors.deepOrange; case AlertSeverity.medium: return Colors.orange; default: return Colors.blue; } }
}
