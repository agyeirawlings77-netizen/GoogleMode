import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../device_management/model/device_model_local.dart';
import '../../../core/theme/app_theme.dart';

class DeviceCard extends StatelessWidget {
  final DeviceModelLocal device;
  final VoidCallback onConnect;
  final VoidCallback onTap;
  final int index;
  const DeviceCard({super.key, required this.device, required this.onConnect, required this.onTap, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(18), border: Border.all(color: device.isOnline ? AppTheme.primaryColor.withOpacity(0.3) : AppTheme.darkBorder)),
        child: Row(children: [
          // Device icon with online indicator
          Stack(children: [
            Container(width: 52, height: 52, decoration: BoxDecoration(color: (device.isOnline ? AppTheme.primaryColor : AppTheme.darkSubtext).withOpacity(0.1), borderRadius: BorderRadius.circular(14)), child: Icon(_icon(device.type), color: device.isOnline ? AppTheme.primaryColor : AppTheme.darkSubtext, size: 26)),
            Positioned(bottom: 2, right: 2, child: Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: device.isOnline ? AppTheme.successColor : Colors.grey.shade600, border: Border.all(color: AppTheme.darkCard, width: 2)))),
          ]),
          const SizedBox(width: 14),

          // Device info
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(device.deviceName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700, fontSize: 15), overflow: TextOverflow.ellipsis)),
              if (device.isTrusted) Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6), border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3))), child: const Text('Trusted', style: TextStyle(color: AppTheme.primaryColor, fontSize: 9, fontWeight: FontWeight.w700))),
            ]),
            const SizedBox(height: 4),
            Row(children: [
              Text(device.isOnline ? 'Online' : 'Offline', style: TextStyle(color: device.isOnline ? AppTheme.successColor : AppTheme.darkSubtext, fontSize: 12, fontWeight: FontWeight.w500)),
              if (device.batteryLevel != null) ...[
                const SizedBox(width: 8),
                Icon(device.batteryLevel! > 20 ? Icons.battery_std : Icons.battery_alert, color: device.batteryLevel! > 20 ? AppTheme.darkSubtext : AppTheme.errorColor, size: 14),
                Text('${device.batteryLevel}%', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
              ],
              if (device.osVersion != null) ...[
                const SizedBox(width: 8),
                Text('Android ${device.osVersion}', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
              ],
            ]),
          ])),

          // Connect button
          if (device.isOnline)
            ElevatedButton(onPressed: onConnect,
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              child: const Text('Connect', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)))
          else
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: AppTheme.darkBorder, borderRadius: BorderRadius.circular(10)), child: const Text('Offline', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12))),
        ]),
      ).animate().fadeIn(delay: Duration(milliseconds: index * 80)).slideX(begin: 0.05),
    );
  }

  IconData _icon(DeviceTypeLocal t) { switch (t) { case DeviceTypeLocal.tablet: return Icons.tablet_android_rounded; case DeviceTypeLocal.laptop: return Icons.laptop_rounded; case DeviceTypeLocal.desktop: return Icons.desktop_windows_rounded; default: return Icons.smartphone_rounded; } }
}
