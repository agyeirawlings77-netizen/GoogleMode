import 'package:equatable/equatable.dart';
abstract class TransferEvent extends Equatable {
  const TransferEvent();
  @override List<Object?> get props => [];
}
class PickAndSendFileEvent extends TransferEvent {
  final String targetDeviceId;
  const PickAndSendFileEvent(this.targetDeviceId);
  @override List<Object?> get props => [targetDeviceId];
}
class DownloadFileEvent extends TransferEvent {
  final String url; final String fileName;
  const DownloadFileEvent({required this.url, required this.fileName});
  @override List<Object?> get props => [url];
}
class LoadTransferHistoryEvent extends TransferEvent { const LoadTransferHistoryEvent(); }
class CancelTransferEvent extends TransferEvent {
  final String transferId;
  const CancelTransferEvent(this.transferId);
  @override List<Object?> get props => [transferId];
}
