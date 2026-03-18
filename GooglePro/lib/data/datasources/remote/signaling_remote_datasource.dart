import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/app_constants.dart';
@singleton
class SignalingRemoteDatasource {
  final _db = FirebaseDatabase.instance;
  Future<void> publishOffer(String to, String from, Map<String, dynamic> sdp) => _db.ref('${AppConstants.signalsPath}/$to/offer').set({'from': from, 'sdp': sdp, 'ts': ServerValue.timestamp});
  Future<void> publishAnswer(String to, String from, Map<String, dynamic> sdp) => _db.ref('${AppConstants.signalsPath}/$to/answer').set({'from': from, 'sdp': sdp, 'ts': ServerValue.timestamp});
  Future<void> publishCandidate(String to, String from, Map<String, dynamic> c) => _db.ref('${AppConstants.signalsPath}/$to/candidates').push().set({'from': from, ...c, 'ts': ServerValue.timestamp});
  Future<void> clear(String uid) => _db.ref('${AppConstants.signalsPath}/$uid').remove();
}
