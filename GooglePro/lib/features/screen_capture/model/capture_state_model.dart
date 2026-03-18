enum CaptureStatus { idle, requesting, capturing, paused, error }
class CaptureStateModel {
  final CaptureStatus status;
  final String? errorMessage;
  final int fps;
  final int bitrateKbps;
  const CaptureStateModel({this.status = CaptureStatus.idle, this.errorMessage, this.fps = 0, this.bitrateKbps = 0});
  CaptureStateModel copyWith({CaptureStatus? status, String? errorMessage, int? fps, int? bitrateKbps}) =>
    CaptureStateModel(status: status ?? this.status, errorMessage: errorMessage, fps: fps ?? this.fps, bitrateKbps: bitrateKbps ?? this.bitrateKbps);
  bool get isCapturing => status == CaptureStatus.capturing;
}
