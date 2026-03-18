import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/app_logger.dart';

class FirestoreHelper {
  static Future<T?> safeGet<T>(Future<T> Function() operation) async {
    try { return await operation(); }
    catch (e, s) { AppLogger.error('Firestore error', e, s); return null; }
  }

  static Future<bool> safeSet(Future<void> Function() operation) async {
    try { await operation(); return true; }
    catch (e, s) { AppLogger.error('Firestore set error', e, s); return false; }
  }

  static Map<String, dynamic> withTimestamp(Map<String, dynamic> data, {bool created = false}) => {
    ...data,
    'updatedAt': FieldValue.serverTimestamp(),
    if (created) 'createdAt': FieldValue.serverTimestamp(),
  };

  static Map<String, dynamic>? fromSnapshot(DocumentSnapshot snap) {
    if (!snap.exists) return null;
    return {...(snap.data() as Map<String, dynamic>), 'id': snap.id};
  }

  static List<Map<String, dynamic>> fromQuerySnapshot(QuerySnapshot snap) =>
    snap.docs.map((d) => {...(d.data() as Map<String, dynamic>), 'id': d.id}).toList();

  static Future<void> runBatch(FirebaseFirestore firestore, List<Map<String, dynamic>> writes) async {
    final batch = firestore.batch();
    for (final write in writes) {
      final ref = write['ref'] as DocumentReference;
      final data = write['data'] as Map<String, dynamic>;
      final type = write['type'] as String? ?? 'set';
      if (type == 'set') batch.set(ref, data, SetOptions(merge: true));
      else if (type == 'update') batch.update(ref, data);
      else if (type == 'delete') batch.delete(ref);
    }
    await batch.commit();
  }
}
