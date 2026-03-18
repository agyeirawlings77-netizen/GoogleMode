enum CaptureStatus { idle, requesting, active, paused, stopped, error }
extension CaptureStatusExt on CaptureStatus {
  bool get isActive => this == CaptureStatus.active;
  String get label { switch (this) { case CaptureStatus.idle: return 'Idle'; case CaptureStatus.requesting: return 'Requesting...'; case CaptureStatus.active: return 'Capturing'; case CaptureStatus.paused: return 'Paused'; case CaptureStatus.stopped: return 'Stopped'; case CaptureStatus.error: return 'Error'; } }
}
