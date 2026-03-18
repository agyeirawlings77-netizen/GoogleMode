import 'package:injectable/injectable.dart';
import '../model/capture_config.dart';
import '../service/screen_capture_manager.dart';
@injectable
class StartCaptureUsecase {
  final ScreenCaptureManager _mgr;
  StartCaptureUsecase(this._mgr);
  Future<String> call(String targetDeviceId, CaptureConfig config) => _mgr.startCapture(targetDeviceId: targetDeviceId, config: config);
}
