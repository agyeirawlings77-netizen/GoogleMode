import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../../webrtc/model/signaling_message.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class SignalingService {
  final _db = FirebaseDatabase.instance;
  final _incomingCtrl = StreamController<SignalingMessage>.broadcast();
  StreamSubscription? _offerSub;
  StreamSubscription? _answerSub;
  StreamSubscription? _candidateSub;
  String? _myUid;

  Stream<SignalingMessage> get incoming => _incomingCtrl.stream;

  String get myUid => _myUid ?? FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> startListening(String uid) async {
    _myUid = uid;
    final base = '${AppConstants.signalsPath}/$uid';

    _offerSub = _db.ref('$base/offer').onValue.listen((event) {
      if (!event.snapshot.exists) return;
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      _incomingCtrl.add(SignalingMessage.fromJson({...data, 'type': 'offer'}));
      AppLogger.info('Signal received: offer from ${data['from']}');
    });

    _answerSub = _db.ref('$base/answer').onValue.listen((event) {
      if (!event.snapshot.exists) return;
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      _incomingCtrl.add(SignalingMessage.fromJson({...data, 'type': 'answer'}));
      AppLogger.info('Signal received: answer');
    });

    _candidateSub = _db.ref('$base/candidates').onChildAdded.listen((event) {
      if (!event.snapshot.exists) return;
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      _incomingCtrl.add(SignalingMessage.fromJson({...data, 'type': 'candidate'}));
    });

    AppLogger.info('Signaling listening for uid: $uid');
  }

  Future<void> sendOffer(String toUid, Map<String, dynamic> sdp) async {
    await _db.ref('${AppConstants.signalsPath}/$toUid/offer').set({'from': myUid, 'sdp': sdp, 'ts': ServerValue.timestamp});
    AppLogger.info('Offer sent to: $toUid');
  }

  Future<void> sendAnswer(String toUid, Map<String, dynamic> sdp) async {
    await _db.ref('${AppConstants.signalsPath}/$toUid/answer').set({'from': myUid, 'sdp': sdp, 'ts': ServerValue.timestamp});
    AppLogger.info('Answer sent to: $toUid');
  }

  Future<void> sendCandidate(String toUid, Map<String, dynamic> candidate) async {
    await _db.ref('${AppConstants.signalsPath}/$toUid/candidates').push().set({'from': myUid, ...candidate, 'ts': ServerValue.timestamp});
  }

  Future<void> sendBye(String toUid) async {
    await _db.ref('${AppConstants.signalsPath}/$toUid/bye').set({'from': myUid, 'ts': ServerValue.timestamp});
    AppLogger.info('Bye sent to: $toUid');
  }

  Future<void> clearSignals(String uid) async {
    await _db.ref('${AppConstants.signalsPath}/$uid').remove();
    AppLogger.debug('Signals cleared for: $uid');
  }

  Future<void> stopListening() async {
    await _offerSub?.cancel();
    await _answerSub?.cancel();
    await _candidateSub?.cancel();
    AppLogger.info('Signaling stopped');
  }

  void dispose() {
    stopListening();
    _incomingCtrl.close();
  }
}
