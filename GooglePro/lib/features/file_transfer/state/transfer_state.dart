import 'package:equatable/equatable.dart';
import '../model/transfer_file.dart';
abstract class TransferState extends Equatable {
  const TransferState();
  @override List<Object?> get props => [];
}
class TransferIdle extends TransferState { const TransferIdle(); }
class TransferLoading extends TransferState { const TransferLoading(); }
class TransferLoaded extends TransferState {
  final List<TransferFile> transfers;
  const TransferLoaded(this.transfers);
  @override List<Object?> get props => [transfers.length];
  List<TransferFile> get active => transfers.where((t) => t.isActive).toList();
  List<TransferFile> get completed => transfers.where((t) => t.isComplete).toList();
}
class TransferInProgress extends TransferState {
  final TransferFile file;
  const TransferInProgress(this.file);
  @override List<Object?> get props => [file.transferId, file.progress];
}
class TransferComplete extends TransferState {
  final TransferFile file;
  const TransferComplete(this.file);
  @override List<Object?> get props => [file.transferId];
}
class TransferError extends TransferState {
  final String message;
  const TransferError(this.message);
  @override List<Object?> get props => [message];
}
