import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class FirestoreService {
  final FirebaseFirestore _db;
  FirestoreService(this._db);

  // Generic CRUD helpers
  Future<void> set(String collection, String docId, Map<String, dynamic> data, {bool merge = true}) async {
    await _db.collection(collection).doc(docId).set({...data, 'updatedAt': FieldValue.serverTimestamp()}, SetOptions(merge: merge));
    AppLogger.debug('Firestore SET: $collection/$docId');
  }

  Future<void> update(String collection, String docId, Map<String, dynamic> data) async {
    await _db.collection(collection).doc(docId).update({...data, 'updatedAt': FieldValue.serverTimestamp()});
  }

  Future<void> delete(String collection, String docId) async {
    await _db.collection(collection).doc(docId).delete();
    AppLogger.debug('Firestore DELETE: $collection/$docId');
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> get(String collection, String docId) => _db.collection(collection).doc(docId).get();

  Future<QuerySnapshot<Map<String, dynamic>>> query(String collection, {String? field, dynamic value, int? limit, String? orderBy, bool descending = false}) async {
    Query<Map<String, dynamic>> q = _db.collection(collection);
    if (field != null && value != null) q = q.where(field, isEqualTo: value);
    if (orderBy != null) q = q.orderBy(orderBy, descending: descending);
    if (limit != null) q = q.limit(limit);
    return q.get();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> watch(String collection, String docId) => _db.collection(collection).doc(docId).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> watchCollection(String collection, {String? field, dynamic value}) {
    if (field != null && value != null) return _db.collection(collection).where(field, isEqualTo: value).snapshots();
    return _db.collection(collection).snapshots();
  }

  WriteBatch batch() => _db.batch();
  Future<T> runTransaction<T>(TransactionHandler<T> handler) => _db.runTransaction(handler);
}
