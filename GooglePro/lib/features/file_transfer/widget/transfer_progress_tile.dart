import 'package:flutter/material.dart';
import '../model/transfer_file.dart';
import '../../../core/theme/app_theme.dart';

class TransferProgressTile extends StatelessWidget {
  final TransferFile file;
  final VoidCallback? onCancel;
  const TransferProgressTile({super.key, required this.file, this.onCancel});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (file.status) {
      case TransferStatus.completed: statusColor = AppTheme.successColor; break;
      case TransferStatus.failed: statusColor = AppTheme.errorColor; break;
      case TransferStatus.inProgress: statusColor = AppTheme.primaryColor; break;
      default: statusColor = AppTheme.darkSubtext;
    }
    return Container(margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppTheme.darkCard, borderRadius: BorderRadius.circular(14), border: Border.all(color: statusColor.withOpacity(0.2))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(_fileIcon(file.mimeType), color: statusColor, size: 22),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(file.fileName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w600, fontSize: 13), overflow: TextOverflow.ellipsis),
            Text('${file.sizeLabel}  •  ${file.direction == TransferDirection.upload ? "↑ Upload" : "↓ Download"}', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 11)),
          ])),
          if (file.isActive && onCancel != null) IconButton(icon: const Icon(Icons.close, size: 16, color: AppTheme.errorColor), onPressed: onCancel, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
          if (file.isComplete) const Icon(Icons.check_circle, color: AppTheme.successColor, size: 18),
          if (file.isFailed) const Icon(Icons.error_outline, color: AppTheme.errorColor, size: 18),
        ]),
        if (file.isActive) ...[
          const SizedBox(height: 8),
          ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: file.progress, minHeight: 5, backgroundColor: AppTheme.darkBorder, valueColor: AlwaysStoppedAnimation<Color>(statusColor))),
          const SizedBox(height: 4),
          Text('${(file.progress * 100).toStringAsFixed(1)}%  •  ${file.sizeLabel}', style: const TextStyle(color: AppTheme.darkSubtext, fontSize: 10)),
        ],
      ]));
  }

  IconData _fileIcon(String mime) {
    if (mime.startsWith('image/')) return Icons.image_outlined;
    if (mime.startsWith('video/')) return Icons.videocam_outlined;
    if (mime.startsWith('audio/')) return Icons.audiotrack_outlined;
    if (mime.contains('pdf')) return Icons.picture_as_pdf_outlined;
    if (mime.contains('zip') || mime.contains('rar')) return Icons.folder_zip_outlined;
    return Icons.attach_file_outlined;
  }
}
