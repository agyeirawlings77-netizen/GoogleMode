import 'package:equatable/equatable.dart';
abstract class FileTransferEvent extends Equatable {
  const FileTransferEvent();
  @override List<Object?> get props => [];
}
class PickAndSendFileEvent extends FileTransferEvent {
  final String targetDeviceId;
  const PickAndSendFileEvent(this.targetDeviceId);
  @override List<Object?> get props => [targetDeviceId];
}
class AcceptFileEvent extends FileTransferEvent {
  final String requestId;
  const AcceptFileEvent(this.requestId);
  @override List<Object?> get props => [requestId];
}
class RejectFileEvent extends FileTransferEvent {
  final String requestId;
  const RejectFileEvent(this.requestId);
  @override List<Object?> get props => [requestId];
}
class CancelTransferEvent extends FileTransferEvent {
  final String transferId;
  const CancelTransferEvent(this.transferId);
  @override List<Object?> get props => [transferId];
}
class LoadTransferHistoryEvent extends FileTransferEvent { const LoadTransferHistoryEvent(); }
