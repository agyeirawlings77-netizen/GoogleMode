class ScreenshotModel {
  final String id;
  final String sessionId;
  final String filePath;
  final DateTime takenAt;
  final int width;
  final int height;
  final int fileSizeBytes;
  const ScreenshotModel({required this.id, required this.sessionId, required this.filePath, required this.takenAt, this.width = 0, this.height = 0, this.fileSizeBytes = 0});
  factory ScreenshotModel.fromJson(Map<String, dynamic> j) => ScreenshotModel(id: j['id'] ?? '', sessionId: j['sessionId'] ?? '', filePath: j['filePath'] ?? '', takenAt: DateTime.parse(j['takenAt']), width: j['width'] ?? 0, height: j['height'] ?? 0, fileSizeBytes: j['fileSizeBytes'] ?? 0);
  Map<String, dynamic> toJson() => {'id': id, 'sessionId': sessionId, 'filePath': filePath, 'takenAt': takenAt.toIso8601String(), 'width': width, 'height': height, 'fileSizeBytes': fileSizeBytes};
}
