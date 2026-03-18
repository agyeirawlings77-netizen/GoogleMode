import 'package:flutter/material.dart';
import '../model/trusted_device_model.dart';
import '../../../core/theme/app_theme.dart';

class TrustConfirmationDialog extends StatelessWidget {
  final String deviceName;
  final String deviceType;
  final String ownerUserId;
  final String deviceId;

  const TrustConfirmationDialog({super.key, required this.deviceName, required this.deviceType, required this.ownerUserId, required this.deviceId});

  static Future<TrustedDeviceModel?> show(BuildContext context, {required String deviceName, required String deviceType, required String ownerUserId, required String deviceId}) {
    return showDialog<TrustedDeviceModel>(context: context, builder: (_) => TrustConfirmationDialog(deviceName: deviceName, deviceType: deviceType, ownerUserId: ownerUserId, deviceId: deviceId));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.darkCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Trust this device?', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), shape: BoxShape.circle),
          child: const Icon(Icons.devices, color: AppTheme.primaryColor, size: 44)),
        const SizedBox(height: 16),
        Text(deviceName, style: const TextStyle(color: AppTheme.darkText, fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        const Text('This device will be able to connect automatically without confirmation.', textAlign: TextAlign.center, style: TextStyle(color: AppTheme.darkSubtext, fontSize: 13, height: 1.5)),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: AppTheme.darkSubtext))),
        ElevatedButton(
          onPressed: () {
            final device = TrustedDeviceModel(deviceId: deviceId, deviceName: deviceName, deviceType: deviceType, ownerUserId: ownerUserId, savedAt: DateTime.now(), lastConnectedAt: DateTime.now(), autoConnect: true);
            Navigator.pop(context, device);
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: const Text('Trust Device', style: TextStyle(fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
