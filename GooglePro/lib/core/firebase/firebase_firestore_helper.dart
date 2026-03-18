import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/app_logger.dart';

class FirebaseFirestoreHelper {
  static final _db = FirebaseFirestore.instance;
  static Future<void> setDoc(String col, String id, Map<String, dynamic> data, {bool merge = true}) async { try { await _db.collection(col).doc(id).set(data, SetOptions(merge: merge)); } catch (e) { AppLogger.error('FS set $col/$id', e); rethrow; } }
  static Future<void> updateDoc(String col, String id, Map<String, dynamic> data) async { try { await _db.collection(col).doc(id).update({...data, 'updatedAt': FieldValue.serverTimestamp()}); } catch (e) { AppLogger.error('FS update $col/$id', e); rethrow; } }
  static Future<DocumentSnapshot?> getDoc(String col, String id) async { try { final s = await _db.collection(col).doc(id).get(); return s.exists ? s : null; } catch (e) { AppLogger.error('FS get $col/$id', e); return null; } }
  static Future<void> deleteDoc(String col, String id) async { try { await _db.collection(col).doc(id).delete(); } catch (e) { AppLogger.error('FS delete $col/$id', e); rethrow; } }
  static Stream<DocumentSnapshot> watchDoc(String col, String id) => _db.collection(col).doc(id).snapshots();
  static Future<QuerySnapshot> query(String col, {String? field, dynamic eq, int? limit}) async { Query q = _db.collection(col); if (field != null && eq != null) q = q.where(field, isEqualTo: eq); if (limit != null) q = q.limit(limit); return q.get(); }
}
