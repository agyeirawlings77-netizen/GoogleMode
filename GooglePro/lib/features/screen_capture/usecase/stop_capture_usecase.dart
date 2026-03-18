import 'package:injectable/injectable.dart';
import '../service/screen_capture_manager.dart';
@injectable
class StopCaptureUsecase {
  final ScreenCaptureManager _mgr;
  StopCaptureUsecase(this._mgr);
  Future<void> call() => _mgr.stopCapture();
}
