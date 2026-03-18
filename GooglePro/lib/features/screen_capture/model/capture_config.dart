class CaptureConfig {
  final int fps;
  final int bitrateKbps;
  final int width;
  final int height;
  final bool audioEnabled;
  const CaptureConfig({this.fps = 15, this.bitrateKbps = 2000, this.width = 1280, this.height = 720, this.audioEnabled = false});
  CaptureConfig copyWith({int? fps, int? bitrateKbps, bool? audioEnabled}) => CaptureConfig(fps: fps ?? this.fps, bitrateKbps: bitrateKbps ?? this.bitrateKbps, width: width, height: height, audioEnabled: audioEnabled ?? this.audioEnabled);
  factory CaptureConfig.fromJson(Map<String, dynamic> j) => CaptureConfig(fps: j['fps'] ?? 15, bitrateKbps: j['bitrateKbps'] ?? 2000, width: j['width'] ?? 1280, height: j['height'] ?? 720, audioEnabled: j['audioEnabled'] ?? false);
  Map<String, dynamic> toJson() => {'fps': fps, 'bitrateKbps': bitrateKbps, 'width': width, 'height': height, 'audioEnabled': audioEnabled};
  static CaptureConfig get low => const CaptureConfig(fps: 10, bitrateKbps: 500, width: 640, height: 480);
  static CaptureConfig get high => const CaptureConfig(fps: 30, bitrateKbps: 4000, width: 1920, height: 1080);
}
