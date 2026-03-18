import 'package:injectable/injectable.dart';
import '../model/transfer_file.dart';
import '../service/file_transfer_service.dart';
@injectable
class SendFileUsecase {
  final FileTransferService _svc;
  SendFileUsecase(this._svc);
  Future<TransferFile?> call(String targetDeviceId) => _svc.pickAndSendFile(targetDeviceId);
}
