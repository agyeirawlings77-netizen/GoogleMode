import '../model/capture_config.dart';
abstract class ScreenCaptureRepository {
  Future<CaptureConfig> getSavedConfig();
  Future<void> saveConfig(CaptureConfig config);
}
