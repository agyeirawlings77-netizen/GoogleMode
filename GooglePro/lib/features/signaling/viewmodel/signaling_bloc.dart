import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/signaling_service.dart';
import '../../webrtc/model/signaling_message.dart';
import '../state/signaling_state.dart';
import '../model/signaling_event.dart';
import '../../../core/utils/app_logger.dart';

class SignalingBloc extends Bloc<SignalingEvent, SignalingState> {
  final SignalingService _svc;
  StreamSubscription? _sub;

  SignalingBloc(this._svc) : super(const SignalingDisconnected()) {
    on<ConnectSignalingEvent>(_onConnect);
    on<DisconnectSignalingEvent>(_onDisconnect);
    on<SendOfferSignalingEvent>(_onSendOffer);
    on<SendAnswerSignalingEvent>(_onSendAnswer);
    on<SendCandidateSignalingEvent>(_onSendCandidate);
  }

  Future<void> _onConnect(ConnectSignalingEvent e, Emitter<SignalingState> emit) async {
    emit(const SignalingConnecting());
    try {
      await _svc.startListening(e.uid);
      emit(const SignalingConnected());
      _sub = _svc.incoming.listen((msg) {
        if (msg.type == SignalingMessageType.offer && msg.payload != null) {
          emit(IncomingOfferState(fromUid: msg.from, sdp: msg.payload!['sdp'] as Map<String, dynamic>));
        }
      });
    } catch (err) { AppLogger.error('Signaling connect failed', err); emit(SignalingError(err.toString())); }
  }

  Future<void> _onDisconnect(DisconnectSignalingEvent e, Emitter<SignalingState> emit) async {
    await _sub?.cancel();
    await _svc.stopListening();
    emit(const SignalingDisconnected());
  }

  Future<void> _onSendOffer(SendOfferSignalingEvent e, Emitter<SignalingState> emit) => _svc.sendOffer(e.toUid, e.sdp);
  Future<void> _onSendAnswer(SendAnswerSignalingEvent e, Emitter<SignalingState> emit) => _svc.sendAnswer(e.toUid, e.sdp);
  Future<void> _onSendCandidate(SendCandidateSignalingEvent e, Emitter<SignalingState> emit) => _svc.sendCandidate(e.toUid, e.candidate);

  @override Future<void> close() async { await _sub?.cancel(); return super.close(); }
}
