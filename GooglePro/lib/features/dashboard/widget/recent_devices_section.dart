import 'package:flutter/material.dart';
import '../../device_management/model/device_model.dart';
import '../../../core/theme/app_theme.dart';

class RecentDevicesSection extends StatelessWidget {
  final List<DeviceModel> devices;
  final ValueChanged<DeviceModel> onDeviceTap;
  const RecentDevicesSection({super.key, required this.devices, required this.onDeviceTap});

  @override
  Widget build(BuildContext context) {
    return Column(children: devices.map((d) => GestureDetector(onTap: () => onDeviceTap(d),
      child: Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: d.isOnline ? AppTheme.primaryColor.withOpacity(0.25) : AppTheme.darkBorder)),
        child: Row(children: [
          Stack(children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Icon(_icon(d.deviceType), color: AppTheme.primaryColor, size: 22)),
            Positioned(right: 0, bottom: 0, child: Container(width: 11, height: 11, decoration: BoxDecoration(shape: BoxShape.circle, color: d.isOnline ? AppTheme.successColor : Colors.grey, border: Border.all(color: AppTheme.darkCard, width: 2)))),
          ]),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(d.deviceName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600, fontSize: 14), overflow: TextOverflow.ellipsis),
            Text(d.isOnline ? 'Online' : 'Offline', style: TextStyle(color: d.isOnline ? AppTheme.successColor : AppTheme.darkSubtext, fontSize: 12)),
          ])),
          if (d.isOnline) Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
            child: const Text('Connect', style: TextStyle(color: AppTheme.primaryColor, fontSize: 12, fontWeight: FontWeight.w600))),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: AppTheme.darkSubtext, size: 18),
        ]))),
    ).toList());
  }

  IconData _icon(String t) { switch (t.toLowerCase()) { case 'tablet': return Icons.tablet_android; case 'laptop': return Icons.laptop; default: return Icons.phone_android; } }
}
