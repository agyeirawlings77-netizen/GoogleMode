import '../model/transfer_file.dart';
abstract class FileTransferRepository {
  Future<List<TransferFile>> getHistory();
  Future<void> saveTransfer(TransferFile transfer);
  Future<void> clearHistory();
}
