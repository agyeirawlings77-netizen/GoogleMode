import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import '../model/transfer_file.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class FileTransferService {
  final FirebaseStorage _storage;
  final FirebaseFirestore _firestore;
  final _progressCtrl = StreamController<TransferFile>.broadcast();
  Stream<TransferFile> get progressStream => _progressCtrl.stream;

  FileTransferService(this._storage, this._firestore);

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<TransferFile?> pickAndSend(String targetDeviceId) async {
    final result = await FilePicker.platform.pickFiles(withData: true, allowMultiple: false);
    if (result == null || result.files.isEmpty) return null;
    final file = result.files.first;
    if (file.bytes == null) return null;
    return await uploadFile(targetDeviceId: targetDeviceId, fileName: file.name, data: file.bytes!, mimeType: file.extension ?? 'application/octet-stream');
  }

  Future<TransferFile> uploadFile({required String targetDeviceId, required String fileName, required Uint8List data, required String mimeType}) async {
    final transfer = TransferFile(transferId: const Uuid().v4(), fileName: fileName, fileSizeBytes: data.length, mimeType: mimeType, direction: TransferDirection.upload, startedAt: DateTime.now());
    transfer.status = TransferStatus.inProgress;
    _progressCtrl.add(transfer);
    try {
      final path = 'transfers/$_uid/${transfer.transferId}/$fileName';
      final ref = _storage.ref(path);
      final uploadTask = ref.putData(data, SettableMetadata(contentType: mimeType));
      uploadTask.snapshotEvents.listen((snap) {
        transfer.bytesTransferred = snap.bytesTransferred;
        _progressCtrl.add(transfer);
      });
      await uploadTask;
      final url = await ref.getDownloadURL();
      transfer.remoteUrl = url;
      transfer.status = TransferStatus.completed;
      transfer.bytesTransferred = data.length;
      await _notifyTarget(targetDeviceId, transfer);
      _progressCtrl.add(transfer);
      AppLogger.info('File uploaded: $fileName → $url');
      return transfer;
    } catch (e, s) {
      transfer.status = TransferStatus.failed;
      _progressCtrl.add(transfer);
      AppLogger.error('Upload failed', e, s);
      rethrow;
    }
  }

  Future<void> _notifyTarget(String targetDeviceId, TransferFile transfer) async {
    await _firestore.collection('file_transfers').add({'from': _uid, 'targetDeviceId': targetDeviceId, 'transferId': transfer.transferId, 'fileName': transfer.fileName, 'fileSize': transfer.fileSizeBytes, 'url': transfer.remoteUrl, 'mimeType': transfer.mimeType, 'ts': FieldValue.serverTimestamp()});
  }

  Stream<List<Map<String, dynamic>>> watchIncoming(String deviceId) => _firestore.collection('file_transfers').where('targetDeviceId', isEqualTo: deviceId).orderBy('ts', descending: true).snapshots().map((s) => s.docs.map((d) => {...d.data(), 'id': d.id}).toList());

  Future<String?> downloadFile(String url, String fileName) async {
    try {
      final ref = _storage.refFromURL(url);
      final data = await ref.getData(100 * 1024 * 1024); // 100MB max
      if (data == null) return null;
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/downloads/$fileName');
      await file.parent.create(recursive: true);
      await file.writeAsBytes(data);
      AppLogger.info('Downloaded: $fileName to ${file.path}');
      return file.path;
    } catch (e) { AppLogger.error('Download failed', e); return null; }
  }

  void dispose() => _progressCtrl.close();
}
