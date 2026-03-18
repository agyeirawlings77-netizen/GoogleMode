enum SessionRole { host, viewer }
enum SessionStatus { idle, connecting, active, paused, ended, error }

class SessionModel {
  final String sessionId;
  final String hostUserId;
  final String viewerUserId;
  final String hostDeviceName;
  final String viewerDeviceName;
  final SessionStatus status;
  final SessionRole role;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final bool audioEnabled;
  final bool videoEnabled;
  final int? fps;
  final int? bitrateKbps;

  const SessionModel({
    required this.sessionId, required this.hostUserId, required this.viewerUserId,
    required this.hostDeviceName, required this.viewerDeviceName,
    this.status = SessionStatus.idle, required this.role,
    this.startedAt, this.endedAt, this.audioEnabled = false,
    this.videoEnabled = true, this.fps, this.bitrateKbps,
  });

  bool get isActive => status == SessionStatus.active;
  Duration get duration => startedAt != null ? (endedAt ?? DateTime.now()).difference(startedAt!) : Duration.zero;

  SessionModel copyWith({SessionStatus? status, bool? audioEnabled, bool? videoEnabled, DateTime? endedAt, int? fps, int? bitrateKbps}) =>
    SessionModel(sessionId: sessionId, hostUserId: hostUserId, viewerUserId: viewerUserId, hostDeviceName: hostDeviceName, viewerDeviceName: viewerDeviceName, status: status ?? this.status, role: role, startedAt: startedAt, endedAt: endedAt ?? this.endedAt, audioEnabled: audioEnabled ?? this.audioEnabled, videoEnabled: videoEnabled ?? this.videoEnabled, fps: fps ?? this.fps, bitrateKbps: bitrateKbps ?? this.bitrateKbps);

  factory SessionModel.fromJson(Map<String, dynamic> j) => SessionModel(
    sessionId: j['sessionId'] ?? '', hostUserId: j['hostUserId'] ?? '', viewerUserId: j['viewerUserId'] ?? '',
    hostDeviceName: j['hostDeviceName'] ?? 'Host', viewerDeviceName: j['viewerDeviceName'] ?? 'Viewer',
    status: SessionStatus.values.firstWhere((s) => s.name == j['status'], orElse: () => SessionStatus.idle),
    role: SessionRole.values.firstWhere((r) => r.name == j['role'], orElse: () => SessionRole.viewer));

  Map<String, dynamic> toJson() => {'sessionId': sessionId, 'hostUserId': hostUserId, 'viewerUserId': viewerUserId, 'hostDeviceName': hostDeviceName, 'viewerDeviceName': viewerDeviceName, 'status': status.name, 'role': role.name, 'startedAt': startedAt?.toIso8601String()};
}
