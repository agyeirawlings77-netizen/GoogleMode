enum RecordingStatus { idle, recording, paused, stopped }
class RecordingModel {
  final String id;
  final String? filePath;
  final RecordingStatus status;
  final DateTime? startedAt;
  final DateTime? stoppedAt;
  final int fileSizeBytes;
  const RecordingModel({required this.id, this.filePath, required this.status, this.startedAt, this.stoppedAt, this.fileSizeBytes = 0});
  Duration get duration => startedAt != null ? (stoppedAt ?? DateTime.now()).difference(startedAt!) : Duration.zero;
  RecordingModel copyWith({String? filePath, RecordingStatus? status, DateTime? startedAt, DateTime? stoppedAt, int? fileSizeBytes}) =>
    RecordingModel(id: id, filePath: filePath ?? this.filePath, status: status ?? this.status, startedAt: startedAt ?? this.startedAt, stoppedAt: stoppedAt ?? this.stoppedAt, fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes);
}
