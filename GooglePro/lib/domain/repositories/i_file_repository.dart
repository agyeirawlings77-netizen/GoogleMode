import 'package:dartz/dartz.dart';
import '../entities/file_entity.dart';

abstract class IFileRepository {
  Future<Either<String, FileEntity>> initiateTransfer({required String targetDeviceId, required String fileName, required List<int> data});
  Future<Either<String, String>> saveReceivedFile(String fileName, List<int> data);
  Future<List<FileEntity>> getTransferHistory();
  Stream<FileEntity> watchTransfer(String fileId);
}
