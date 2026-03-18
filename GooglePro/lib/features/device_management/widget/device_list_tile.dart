import 'package:flutter/material.dart';
import '../model/device_model_local.dart';
import '../../../core/theme/app_theme.dart';

class DeviceListTile extends StatelessWidget {
  final DeviceModelLocal device;
  final int index;
  final VoidCallback onConnect;
  final VoidCallback? onMoreOptions;
  const DeviceListTile({super.key, required this.device, this.index = 0, required this.onConnect, this.onMoreOptions});

  @override
  Widget build(BuildContext context) {
    return Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: device.isOnline ? AppTheme.primaryColor.withOpacity(0.25) : AppTheme.darkBorder)),
      child: Row(children: [
        Stack(children: [
          Container(width: 46, height: 46, decoration: BoxDecoration(color: (device.isOnline ? AppTheme.primaryColor : AppTheme.darkSubtext).withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(_icon(device.type), color: device.isOnline ? AppTheme.primaryColor : AppTheme.darkSubtext, size: 22)),
          Positioned(bottom: 0, right: 0, child: Container(width: 11, height: 11, decoration: BoxDecoration(shape: BoxShape.circle, color: device.isOnline ? AppTheme.successColor : Colors.grey, border: Border.all(color: AppTheme.darkCard, width: 1.5)))),
        ]),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(device.deviceName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600, fontSize: 14)),
          Row(children: [
            Text(device.isOnline ? 'Online' : 'Offline', style: TextStyle(color: device.isOnline ? AppTheme.successColor : AppTheme.darkSubtext, fontSize: 11)),
            if (device.isTrusted) ...[const Text(' · ', style: TextStyle(color: AppTheme.darkSubtext)), const Text('Trusted', style: TextStyle(color: AppTheme.primaryColor, fontSize: 11, fontWeight: FontWeight.w600))],
            if (device.osVersion != null) Text(' · Android ${device.osVersion}', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
          ]),
        ])),
        if (device.isOnline) ElevatedButton(onPressed: onConnect, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)), child: const Text('Connect')),
        if (onMoreOptions != null) IconButton(icon: const Icon(Icons.more_vert, color: AppTheme.darkSubtext, size: 18), onPressed: onMoreOptions),
      ]));
  }

  IconData _icon(DeviceTypeLocal t) { switch (t) { case DeviceTypeLocal.tablet: return Icons.tablet_android_rounded; case DeviceTypeLocal.laptop: return Icons.laptop_rounded; case DeviceTypeLocal.desktop: return Icons.desktop_windows_rounded; default: return Icons.smartphone_rounded; } }
}
