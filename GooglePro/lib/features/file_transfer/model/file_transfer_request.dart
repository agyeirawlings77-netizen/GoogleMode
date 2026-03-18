class FileTransferRequest {
  final String requestId;
  final String fromDeviceId;
  final String fromDeviceName;
  final String fileName;
  final int fileSizeBytes;
  final String mimeType;
  const FileTransferRequest({required this.requestId, required this.fromDeviceId, required this.fromDeviceName, required this.fileName, required this.fileSizeBytes, required this.mimeType});
  factory FileTransferRequest.fromJson(Map<String, dynamic> j) => FileTransferRequest(requestId: j['requestId'] ?? '', fromDeviceId: j['fromDeviceId'] ?? '', fromDeviceName: j['fromDeviceName'] ?? '', fileName: j['fileName'] ?? '', fileSizeBytes: j['fileSizeBytes'] ?? 0, mimeType: j['mimeType'] ?? '');
  Map<String, dynamic> toJson() => {'requestId': requestId, 'fromDeviceId': fromDeviceId, 'fromDeviceName': fromDeviceName, 'fileName': fileName, 'fileSizeBytes': fileSizeBytes, 'mimeType': mimeType};
}
