import 'package:flutter/material.dart';
import '../model/file_transfer_request.dart';
import '../../../core/theme/app_theme.dart';

class IncomingFileDialog extends StatelessWidget {
  final FileTransferRequest request;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  const IncomingFileDialog({super.key, required this.request, required this.onAccept, required this.onReject});

  static Future<bool?> show(BuildContext context, FileTransferRequest request) => showDialog<bool>(context: context, builder: (_) => IncomingFileDialog(request: request, onAccept: () => Navigator.pop(context, true), onReject: () => Navigator.pop(context, false)));

  @override
  Widget build(BuildContext context) {
    final sizeMb = (request.fileSizeBytes / 1048576).toStringAsFixed(1);
    return AlertDialog(
      backgroundColor: AppTheme.darkCard, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Incoming File', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.attach_file, color: AppTheme.primaryColor, size: 40)),
        const SizedBox(height: 12),
        Text(request.fileName, style: const TextStyle(color: AppTheme.darkText, fontSize: 16, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
        const SizedBox(height: 4),
        Text('$sizeMb MB • from ${request.fromDeviceName}', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 13)),
      ]),
      actions: [
        TextButton(onPressed: onReject, child: const Text('Decline', style: TextStyle(color: AppTheme.darkSubtext))),
        ElevatedButton(onPressed: onAccept,
          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: const Text('Accept', style: TextStyle(fontWeight: FontWeight.w700))),
      ],
    );
  }
}
