class SessionScreenshot {
  final String sessionId;
  final String filePath;
  final DateTime takenAt;
  final int width;
  final int height;
  const SessionScreenshot({required this.sessionId, required this.filePath, required this.takenAt, this.width = 0, this.height = 0});
}
