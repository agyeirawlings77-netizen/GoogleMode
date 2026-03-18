import 'package:flutter/material.dart';
import '../../device_management/model/device_model.dart';
import '../../../core/theme/app_theme.dart';
class DeviceListItem extends StatelessWidget {
  final DeviceModel device;
  final VoidCallback onTap;
  const DeviceListItem({super.key, required this.device, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,
      child: Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: device.isOnline ? AppTheme.primaryColor.withOpacity(0.2) : AppTheme.darkBorder)),
        child: Row(children: [
          Container(width: 38, height: 38, decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(9)), child: const Icon(Icons.phone_android, color: AppTheme.primaryColor, size: 20)),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(device.deviceName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600, fontSize: 13), overflow: TextOverflow.ellipsis),
            Text(device.isOnline ? 'Online' : 'Offline', style: TextStyle(color: device.isOnline ? AppTheme.successColor : AppTheme.darkSubtext, fontSize: 11)),
          ])),
          const Icon(Icons.chevron_right, color: AppTheme.darkSubtext, size: 16),
        ])));
  }
}
