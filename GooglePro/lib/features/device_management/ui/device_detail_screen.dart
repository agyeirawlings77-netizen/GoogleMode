import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../model/device_model_local.dart';
import '../../../core/theme/app_theme.dart';

class DeviceDetailScreen extends StatelessWidget {
  final DeviceModelLocal device;
  const DeviceDetailScreen({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: Text(device.deviceName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        // Device header
        Center(child: Column(children: [
          Container(width: 80, height: 80, decoration: BoxDecoration(color: (device.isOnline ? AppTheme.primaryColor : AppTheme.darkSubtext).withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: Icon(Icons.smartphone_rounded, color: device.isOnline ? AppTheme.primaryColor : AppTheme.darkSubtext, size: 40)),
          const SizedBox(height: 12),
          Text(device.deviceName, style: const TextStyle(color: AppTheme.darkText, fontSize: 22, fontWeight: FontWeight.w700)),
          Container(margin: const EdgeInsets.only(top: 6), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: (device.isOnline ? AppTheme.successColor : Colors.grey).withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: Text(device.isOnline ? 'Online' : 'Offline', style: TextStyle(color: device.isOnline ? AppTheme.successColor : Colors.grey, fontWeight: FontWeight.w600, fontSize: 13))),
        ])).animate().fadeIn(),

        const SizedBox(height: 28),
        // Actions grid
        if (device.isOnline) ...[
          const Text('ACTIONS', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
          const SizedBox(height: 12),
          GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.0,
            children: [
              _actionBtn(context, Icons.screen_share_rounded, 'Screen\nShare', AppTheme.primaryColor, () => context.push('/session/${device.deviceId}')),
              _actionBtn(context, Icons.touch_app_rounded, 'Remote\nControl', const Color(0xFF7C4DFF), () => context.push('/remote-control/${device.deviceId}')),
              _actionBtn(context, Icons.folder_open_rounded, 'File\nTransfer', AppTheme.accentColor, () => context.push('/file-transfer/${device.deviceId}')),
              _actionBtn(context, Icons.mic_rounded, 'Voice\nCall', const Color(0xFF00BFA5), () => context.push('/voice-call/${device.deviceId}')),
              _actionBtn(context, Icons.location_on_rounded, 'Location', AppTheme.errorColor, () => context.push('/location/${device.deviceId}')),
              _actionBtn(context, Icons.child_care_rounded, 'Parental', const Color(0xFFFF6D00), () => context.push('/parental-controls/${device.deviceId}')),
            ]),
          const SizedBox(height: 20),
        ],

        // Device info
        const Text('DEVICE INFO', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
        const SizedBox(height: 12),
        _infoCard([
          if (device.osVersion != null) _infoRow('OS', 'Android ${device.osVersion}'),
          if (device.appVersion != null) _infoRow('App Version', device.appVersion!),
          if (device.batteryLevel != null) _infoRow('Battery', '${device.batteryLevel}%'),
          _infoRow('Type', device.typeLabel),
          _infoRow('Trusted', device.isTrusted ? 'Yes' : 'No'),
        ]),
      ]),
    );
  }

  Widget _actionBtn(BuildContext ctx, IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle), child: Icon(icon, color: color, size: 20)),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: AppTheme.darkText, fontSize: 10, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
      ])));
  }

  Widget _infoCard(List<Widget> rows) => Container(decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppTheme.darkBorder)), child: Column(children: rows));
  Widget _infoRow(String label, String value) => Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Row(children: [Text(label, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 13)), const Spacer(), Text(value, style: const TextStyle(color: AppTheme.darkText, fontSize: 13, fontWeight: FontWeight.w500))]));
}
