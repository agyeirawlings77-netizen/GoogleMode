import 'package:equatable/equatable.dart';
abstract class SignalingEvent extends Equatable {
  const SignalingEvent();
  @override List<Object?> get props => [];
}
class ConnectSignalingEvent extends SignalingEvent {
  final String uid;
  const ConnectSignalingEvent(this.uid);
  @override List<Object?> get props => [uid];
}
class DisconnectSignalingEvent extends SignalingEvent { const DisconnectSignalingEvent(); }
class SendOfferSignalingEvent extends SignalingEvent {
  final String toUid;
  final Map<String, dynamic> sdp;
  const SendOfferSignalingEvent(this.toUid, this.sdp);
  @override List<Object?> get props => [toUid];
}
class SendAnswerSignalingEvent extends SignalingEvent {
  final String toUid;
  final Map<String, dynamic> sdp;
  const SendAnswerSignalingEvent(this.toUid, this.sdp);
  @override List<Object?> get props => [toUid];
}
class SendCandidateSignalingEvent extends SignalingEvent {
  final String toUid;
  final Map<String, dynamic> candidate;
  const SendCandidateSignalingEvent(this.toUid, this.candidate);
}
