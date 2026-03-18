enum TransferStatus { pending, inProgress, paused, completed, failed, cancelled }
enum TransferDirection { upload, download }

class TransferFile {
  final String transferId;
  final String fileName;
  final int fileSizeBytes;
  final String mimeType;
  final TransferDirection direction;
  TransferStatus status;
  int bytesTransferred;
  String? localPath;
  String? remoteUrl;
  final DateTime startedAt;

  TransferFile({required this.transferId, required this.fileName, required this.fileSizeBytes, required this.mimeType, required this.direction, this.status = TransferStatus.pending, this.bytesTransferred = 0, this.localPath, this.remoteUrl, required this.startedAt});

  double get progress => fileSizeBytes > 0 ? (bytesTransferred / fileSizeBytes).clamp(0.0, 1.0) : 0.0;
  bool get isComplete => status == TransferStatus.completed;
  bool get isFailed => status == TransferStatus.failed;
  bool get isActive => status == TransferStatus.inProgress;
  String get sizeLabel { if (fileSizeBytes < 1024) return '$fileSizeBytes B'; if (fileSizeBytes < 1048576) return '${(fileSizeBytes / 1024).toStringAsFixed(1)} KB'; return '${(fileSizeBytes / 1048576).toStringAsFixed(1)} MB'; }
}
