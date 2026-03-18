class SessionConfig {
  final int fps;
  final int bitrateKbps;
  final bool audioEnabled;
  final bool videoEnabled;
  final bool remoteControlEnabled;
  final bool fileTransferEnabled;
  const SessionConfig({this.fps = 15, this.bitrateKbps = 2000, this.audioEnabled = true, this.videoEnabled = true, this.remoteControlEnabled = false, this.fileTransferEnabled = true});
  SessionConfig copyWith({int? fps, int? bitrateKbps, bool? audioEnabled, bool? videoEnabled, bool? remoteControlEnabled, bool? fileTransferEnabled}) =>
    SessionConfig(fps: fps ?? this.fps, bitrateKbps: bitrateKbps ?? this.bitrateKbps, audioEnabled: audioEnabled ?? this.audioEnabled, videoEnabled: videoEnabled ?? this.videoEnabled, remoteControlEnabled: remoteControlEnabled ?? this.remoteControlEnabled, fileTransferEnabled: fileTransferEnabled ?? this.fileTransferEnabled);
}
