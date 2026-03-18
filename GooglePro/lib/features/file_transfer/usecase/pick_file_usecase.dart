import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
@injectable
class PickFileUsecase {
  Future<PlatformFile?> call() async {
    final result = await FilePicker.platform.pickFiles(withData: true, allowMultiple: false);
    return result?.files.firstOrNull;
  }
}
