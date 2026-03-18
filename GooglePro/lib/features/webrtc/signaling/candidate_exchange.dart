import 'dart:async';
import 'package:firebase_webrtc/flutter_webrtc.dart' show RTCPeerConnection, RTCIceCandidate;
import 'package:injectable/injectable.dart';
import 'signaling_repository.dart';
import '../model/ice_candidate_model.dart';

// Bridges RTCPeerConnection ICE events to Firebase signaling
class CandidateExchange {
  final SignalingRepository _repo;
  final String localUid;
  final String remoteUid;
  final RTCPeerConnection pc;
  final List<StreamSubscription> _subs = [];

  CandidateExchange(this._repo, this.localUid, this.remoteUid, this.pc);

  void start() {
    // Listen for local ICE candidates
    pc.onIceCandidate = (c) {
      if (c.candidate == null) return;
      _repo.sendIceCandidate(localUid, remoteUid, IceCandidateModel(candidate: c.candidate!, sdpMid: c.sdpMid ?? '0', sdpMLineIndex: c.sdpMLineIndex ?? 0).toJson());
    };
    // Watch remote candidates
    final sub = _repo.watchIceCandidates(localUid).listen((data) async {
      if (data == null) return;
      try { await pc.addCandidate(RTCIceCandidate(data['candidate'], data['sdpMid'], data['sdpMLineIndex'])); } catch (_) {}
    });
    _subs.add(sub);
  }

  void dispose() { pc.onIceCandidate = null; for (final s in _subs) s.cancel(); _subs.clear(); }
}
