import 'package:equatable/equatable.dart';
class SessionParticipant extends Equatable {
  final String uid;
  final String displayName;
  final String? photoUrl;
  final bool isMuted;
  final bool isVideoOff;
  const SessionParticipant({required this.uid, required this.displayName, this.photoUrl, this.isMuted = false, this.isVideoOff = false});
  @override List<Object?> get props => [uid, isMuted, isVideoOff];
  SessionParticipant copyWith({bool? isMuted, bool? isVideoOff}) => SessionParticipant(uid: uid, displayName: displayName, photoUrl: photoUrl, isMuted: isMuted ?? this.isMuted, isVideoOff: isVideoOff ?? this.isVideoOff);
}
