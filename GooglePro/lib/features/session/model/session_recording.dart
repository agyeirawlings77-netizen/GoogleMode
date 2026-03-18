class SessionRecording {
  final String sessionId;
  final String filePath;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int fileSizeBytes;
  const SessionRecording({required this.sessionId, required this.filePath, required this.startedAt, this.endedAt, this.fileSizeBytes = 0});
  Duration get duration => startedAt != null ? (endedAt ?? DateTime.now()).difference(startedAt) : Duration.zero;
}
