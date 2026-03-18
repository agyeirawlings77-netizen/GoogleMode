import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/file_transfer_service.dart';
import '../model/transfer_file.dart';
import '../state/transfer_state.dart';
import '../state/transfer_event.dart';
import '../../../core/utils/app_logger.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final FileTransferService _svc;
  StreamSubscription? _progressSub;
  final List<TransferFile> _transfers = [];

  TransferBloc(this._svc) : super(const TransferIdle()) {
    on<PickAndSendFileEvent>(_onPickAndSend);
    on<DownloadFileEvent>(_onDownload);
    on<LoadTransferHistoryEvent>((e, emit) => emit(TransferLoaded(List.from(_transfers))));
    on<CancelTransferEvent>((e, emit) {
      final t = _transfers.firstWhere((f) => f.transferId == e.transferId, orElse: () => TransferFile(transferId: '', fileName: '', fileSizeBytes: 0, mimeType: '', direction: TransferDirection.upload, startedAt: DateTime.now()));
      t.status = TransferStatus.cancelled;
      emit(TransferLoaded(List.from(_transfers)));
    });
    _progressSub = _svc.progressStream.listen((file) {
      final idx = _transfers.indexWhere((t) => t.transferId == file.transferId);
      if (idx >= 0) _transfers[idx] = file; else _transfers.insert(0, file);
      if (file.isComplete) add(LoadTransferHistoryEvent());
    });
  }

  Future<void> _onPickAndSend(PickAndSendFileEvent e, Emitter<TransferState> emit) async {
    emit(const TransferLoading());
    try {
      final file = await _svc.pickAndSend(e.targetDeviceId);
      if (file == null) { emit(const TransferIdle()); return; }
      emit(TransferLoaded(List.from(_transfers)));
    } catch (err) { AppLogger.error('Transfer failed', err); emit(TransferError(err.toString())); }
  }

  Future<void> _onDownload(DownloadFileEvent e, Emitter<TransferState> emit) async {
    try {
      final path = await _svc.downloadFile(e.url, e.fileName);
      if (path != null) AppLogger.info('Downloaded to $path');
    } catch (err) { emit(TransferError(err.toString())); }
  }

  @override Future<void> close() async { await _progressSub?.cancel(); return super.close(); }
}
