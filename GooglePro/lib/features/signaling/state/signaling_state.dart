import 'package:equatable/equatable.dart';
abstract class SignalingState extends Equatable {
  const SignalingState();
  @override List<Object?> get props => [];
}
class SignalingDisconnected extends SignalingState { const SignalingDisconnected(); }
class SignalingConnecting extends SignalingState { const SignalingConnecting(); }
class SignalingConnected extends SignalingState { const SignalingConnected(); }
class SignalingError extends SignalingState {
  final String message;
  const SignalingError(this.message);
  @override List<Object?> get props => [message];
}
class IncomingOfferState extends SignalingState {
  final String fromUid;
  final Map<String, dynamic> sdp;
  const IncomingOfferState({required this.fromUid, required this.sdp});
  @override List<Object?> get props => [fromUid];
}
