import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DeviceActionMenu extends StatelessWidget {
  final String deviceId;
  final String deviceName;
  final VoidCallback onRename;
  final VoidCallback onConnect;
  final VoidCallback onParental;
  final VoidCallback onLocation;
  final VoidCallback onDelete;
  const DeviceActionMenu({super.key, required this.deviceId, required this.deviceName, required this.onRename, required this.onConnect, required this.onParental, required this.onLocation, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 40, height: 4, decoration: BoxDecoration(color: AppTheme.darkBorder, borderRadius: BorderRadius.circular(2)), margin: const EdgeInsets.only(bottom: 16)),
      Text(deviceName, style: const TextStyle(color: AppTheme.darkText, fontSize: 16, fontWeight: FontWeight.w700)),
      const SizedBox(height: 16),
      _tile(Icons.cable_outlined, 'Connect', AppTheme.primaryColor, onConnect),
      _tile(Icons.edit_outlined, 'Rename', AppTheme.darkText, onRename),
      _tile(Icons.child_care_rounded, 'Parental Controls', Colors.orange, onParental),
      _tile(Icons.location_on_outlined, 'Track Location', AppTheme.errorColor, onLocation),
      _tile(Icons.delete_outline, 'Remove Device', AppTheme.errorColor, onDelete),
    ]);
  }

  Widget _tile(IconData icon, String label, Color color, VoidCallback onTap) {
    return ListTile(leading: Icon(icon, color: color, size: 20), title: Text(label, style: TextStyle(color: color)), onTap: onTap, contentPadding: EdgeInsets.zero);
  }
}
