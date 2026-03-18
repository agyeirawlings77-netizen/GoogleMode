import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../model/parental_profile.dart';
@singleton
class ParentalRemoteDatasource {
  final FirebaseFirestore _firestore;
  ParentalRemoteDatasource(this._firestore);
  Future<void> save(ParentalProfile p) => _firestore.collection('parental_profiles').doc(p.profileId).set(p.toJson(), SetOptions(merge: true));
  Future<ParentalProfile?> get(String deviceId) async {
    final snap = await _firestore.collection('parental_profiles').where('deviceId', isEqualTo: deviceId).limit(1).get();
    if (snap.docs.isEmpty) return null;
    return ParentalProfile.fromJson({...snap.docs.first.data(), 'profileId': snap.docs.first.id});
  }
}
