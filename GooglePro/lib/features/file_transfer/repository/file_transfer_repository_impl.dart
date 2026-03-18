import 'package:injectable/injectable.dart';
import '../datasource/file_transfer_local_datasource.dart';
import '../model/transfer_file.dart';
import 'file_transfer_repository.dart';
@LazySingleton(as: FileTransferRepository)
class FileTransferRepositoryImpl implements FileTransferRepository {
  final FileTransferLocalDatasource _local;
  FileTransferRepositoryImpl(this._local);
  @override Future<List<TransferFile>> getHistory() async => [];
  @override Future<void> saveTransfer(TransferFile t) async => _local.save({'transferId': t.transferId, 'fileName': t.fileName, 'direction': t.direction.name, 'status': t.status.name});
  @override Future<void> clearHistory() async => {};
}
