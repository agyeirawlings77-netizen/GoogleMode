import 'package:injectable/injectable.dart';
import '../model/transfer_file.dart';
import '../repository/file_transfer_repository.dart';
@injectable
class GetTransferHistoryUsecase {
  final FileTransferRepository _repo;
  GetTransferHistoryUsecase(this._repo);
  Future<List<TransferFile>> call() => _repo.getHistory();
}
