import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import '../../core/utils/app_logger.dart';

@singleton
class FirebaseStorageService {
  final FirebaseStorage _storage;
  FirebaseStorageService(this._storage);

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';

  Future<String> uploadFile(String path, Uint8List data, {String? contentType}) async {
    try {
      final ref = _storage.ref('users/$_uid/$path');
      final task = await ref.putData(data, SettableMetadata(contentType: contentType ?? 'application/octet-stream'));
      final url = await task.ref.getDownloadURL();
      AppLogger.info('Uploaded: $path → $url');
      return url;
    } catch (e, s) { AppLogger.error('Upload failed', e, s); rethrow; }
  }

  Future<String> uploadProfilePhoto(Uint8List data) => uploadFile('profile/avatar.jpg', data, contentType: 'image/jpeg');
  Future<String> uploadTransferFile(String fileName, Uint8List data) => uploadFile('transfers/$fileName', data);
  Future<String> uploadIntruderPhoto(Uint8List data) => uploadFile('security/intruder_${DateTime.now().millisecondsSinceEpoch}.jpg', data, contentType: 'image/jpeg');

  Future<Uint8List?> downloadFile(String url) async {
    try {
      final ref = _storage.refFromURL(url);
      return await ref.getData(10 * 1024 * 1024); // max 10MB
    } catch (e) { AppLogger.error('Download failed', e); return null; }
  }

  Future<void> deleteFile(String url) async {
    try { await _storage.refFromURL(url).delete(); }
    catch (e) { AppLogger.warning('Delete failed: $e'); }
  }
}
