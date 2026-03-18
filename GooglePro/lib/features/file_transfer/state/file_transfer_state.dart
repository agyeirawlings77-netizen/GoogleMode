import 'package:equatable/equatable.dart';
import '../model/transfer_file.dart';
import '../model/file_transfer_request.dart';

abstract class FileTransferState extends Equatable {
  const FileTransferState();
  @override List<Object?> get props => [];
}
class FileTransferIdle extends FileTransferState { const FileTransferIdle(); }
class FileTransferLoaded extends FileTransferState {
  final List<TransferFile> transfers;
  const FileTransferLoaded(this.transfers);
  @override List<Object?> get props => [transfers];
}
class FileTransferIncoming extends FileTransferState {
  final FileTransferRequest request;
  const FileTransferIncoming(this.request);
  @override List<Object?> get props => [request];
}
class FileTransferProgress extends FileTransferState {
  final String transferId;
  final double progress;
  final int bytesPerSecond;
  const FileTransferProgress({required this.transferId, required this.progress, this.bytesPerSecond = 0});
  @override List<Object?> get props => [transferId, progress];
}
class FileTransferComplete extends FileTransferState {
  final String fileName;
  final String? savedPath;
  const FileTransferComplete({required this.fileName, this.savedPath});
  @override List<Object?> get props => [fileName];
}
class FileTransferError extends FileTransferState {
  final String message;
  const FileTransferError(this.message);
  @override List<Object?> get props => [message];
}
