import '../../../core/constants/app_constants.dart';

class ScreenCaptureConfig {
  final int fps;
  final int bitrateKbps;
  final int width;
  final int height;
  final bool captureAudio;
  final ScreenQuality quality;

  const ScreenCaptureConfig({
    this.fps = 15, this.bitrateKbps = 2000,
    this.width = 1280, this.height = 720,
    this.captureAudio = false,
    this.quality = ScreenQuality.hd,
  });

  static const low = ScreenCaptureConfig(fps: 10, bitrateKbps: 500, width: 640, height: 360, quality: ScreenQuality.low);
  static const medium = ScreenCaptureConfig(fps: 15, bitrateKbps: 1500, width: 1280, height: 720, quality: ScreenQuality.medium);
  static const hd = ScreenCaptureConfig(fps: 20, bitrateKbps: 3000, width: 1920, height: 1080, quality: ScreenQuality.hd);

  ScreenCaptureConfig copyWith({int? fps, int? bitrateKbps, int? width, int? height, bool? captureAudio, ScreenQuality? quality}) =>
    ScreenCaptureConfig(fps: fps ?? this.fps, bitrateKbps: bitrateKbps ?? this.bitrateKbps, width: width ?? this.width, height: height ?? this.height, captureAudio: captureAudio ?? this.captureAudio, quality: quality ?? this.quality);
}

enum ScreenQuality { low, medium, hd }
extension ScreenQualityExt on ScreenQuality {
  String get label { switch (this) { case ScreenQuality.low: return 'Low (360p)'; case ScreenQuality.medium: return 'Medium (720p)'; case ScreenQuality.hd: return 'HD (1080p)'; } }
}
