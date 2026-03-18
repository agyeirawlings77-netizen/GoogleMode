import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/theme/app_theme.dart';

class DevicePermissionsScreen extends StatefulWidget {
  const DevicePermissionsScreen({super.key});
  @override State<DevicePermissionsScreen> createState() => _DevicePermissionsScreenState();
}

class _DevicePermissionsScreenState extends State<DevicePermissionsScreen> {
  Map<String, bool> _permissions = {};

  @override
  void initState() { super.initState(); _checkAll(); }

  Future<void> _checkAll() async {
    final results = await [Permission.camera, Permission.microphone, Permission.location, Permission.storage, Permission.notification].request();
    setState(() { _permissions = {for (final e in results.entries) e.key.toString().split('.').last: e.value.isGranted}; });
  }

  @override
  Widget build(BuildContext context) {
    final perms = [
      {'key': 'camera', 'label': 'Camera', 'icon': Icons.camera_alt_outlined, 'desc': 'Required for screen capture preview'},
      {'key': 'microphone', 'label': 'Microphone', 'icon': Icons.mic_outlined, 'desc': 'Required for voice calls'},
      {'key': 'location', 'label': 'Location', 'icon': Icons.location_on_outlined, 'desc': 'Required for device tracking'},
      {'key': 'storage', 'label': 'Storage', 'icon': Icons.folder_outlined, 'desc': 'Required for file transfer'},
      {'key': 'notification', 'label': 'Notifications', 'icon': Icons.notifications_outlined, 'desc': 'Required for connection alerts'},
    ];
    return Scaffold(backgroundColor: AppTheme.darkBg,
      appBar: AppBar(title: const Text('Permissions', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Grant the following permissions for full functionality.', style: TextStyle(color: AppTheme.darkSubtext, height: 1.5)),
        const SizedBox(height: 20),
        ...perms.map((p) {
          final granted = _permissions[p['key']] ?? false;
          return Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: granted ? AppTheme.successColor.withOpacity(0.3) : AppTheme.darkBorder)),
            child: Row(children: [
              Icon(p['icon'] as IconData, color: granted ? AppTheme.successColor : AppTheme.darkSubtext, size: 24),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(p['label'] as String, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600)), Text(p['desc'] as String, style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 12))])),
              granted ? const Icon(Icons.check_circle, color: AppTheme.successColor, size: 20) : TextButton(onPressed: () async { await openAppSettings(); _checkAll(); }, child: const Text('Grant', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w600, fontSize: 12))),
            ]));
        }),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => context.pop(), style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: const Text('Continue', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
      ]));
  }
}
