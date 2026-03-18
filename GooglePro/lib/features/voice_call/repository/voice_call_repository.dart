abstract class VoiceCallRepository {
  Future<void> initiateCall(String callerId, String receiverId);
  Future<void> endCall(String callId);
  Future<void> acceptCall(String callId);
  Future<void> rejectCall(String callId);
}
