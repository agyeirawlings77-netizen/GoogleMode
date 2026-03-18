import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DeviceRenameDialog extends StatefulWidget {
  final String currentName;
  const DeviceRenameDialog({super.key, required this.currentName});

  static Future<String?> show(BuildContext context, String currentName) {
    return showDialog<String>(context: context, builder: (_) => DeviceRenameDialog(currentName: currentName));
  }

  @override State<DeviceRenameDialog> createState() => _DeviceRenameDialogState();
}

class _DeviceRenameDialogState extends State<DeviceRenameDialog> {
  late final TextEditingController _ctrl;
  @override void initState() { super.initState(); _ctrl = TextEditingController(text: widget.currentName); }
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.darkCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Rename Device', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)),
      content: TextField(controller: _ctrl, autofocus: true,
        style: const TextStyle(color: AppTheme.darkText),
        decoration: InputDecoration(filled: true, fillColor: AppTheme.darkSurface,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.darkBorder)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2)))),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: AppTheme.darkSubtext))),
        ElevatedButton(onPressed: () => Navigator.pop(context, _ctrl.text.trim()),
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: const Text('Save', style: TextStyle(fontWeight: FontWeight.w700))),
      ],
    );
  }
}
