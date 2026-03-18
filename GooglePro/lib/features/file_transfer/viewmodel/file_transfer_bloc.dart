import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/file_transfer_service.dart';
import '../state/file_transfer_state.dart';
import '../state/file_transfer_event.dart';
import '../../../core/utils/app_logger.dart';

class FileTransferBloc extends Bloc<FileTransferEvent, FileTransferState> {
  final FileTransferService _service;
  FileTransferBloc(this._service) : super(const FileTransferIdle()) {
    on<PickAndSendFileEvent>(_onPickAndSend);
    on<AcceptFileEvent>(_onAccept);
    on<RejectFileEvent>(_onReject);
    on<CancelTransferEvent>(_onCancel);
    on<LoadTransferHistoryEvent>(_onLoadHistory);
  }

  Future<void> _onPickAndSend(PickAndSendFileEvent e, Emitter<FileTransferState> emit) async {
    try {
      final transfer = await _service.pickAndSendFile(e.targetDeviceId);
      if (transfer != null) emit(FileTransferComplete(fileName: transfer.fileName));
      else emit(const FileTransferIdle());
    } catch (e, s) {
      AppLogger.error('Pick and send failed', e, s);
      emit(FileTransferError(e.toString()));
    }
  }

  void _onAccept(AcceptFileEvent e, Emitter<FileTransferState> emit) {
    AppLogger.info('Accepted file transfer: ${e.requestId}');
  }

  void _onReject(RejectFileEvent e, Emitter<FileTransferState> emit) {
    emit(const FileTransferIdle());
  }

  void _onCancel(CancelTransferEvent e, Emitter<FileTransferState> emit) {
    emit(const FileTransferIdle());
  }

  void _onLoadHistory(LoadTransferHistoryEvent e, Emitter<FileTransferState> emit) {
    emit(FileTransferLoaded(_service.activeTransfers));
  }
}
