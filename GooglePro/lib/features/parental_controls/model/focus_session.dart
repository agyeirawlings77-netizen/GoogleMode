class FocusSession {
  final String sessionId;
  final String deviceId;
  final int durationMinutes;
  final DateTime startedAt;
  final bool blockAllApps;
  final List<String> allowedApps;
  const FocusSession({required this.sessionId, required this.deviceId, required this.durationMinutes, required this.startedAt, this.blockAllApps = true, this.allowedApps = const []});
  bool get isActive => DateTime.now().isBefore(startedAt.add(Duration(minutes: durationMinutes)));
  Duration get remaining => startedAt.add(Duration(minutes: durationMinutes)).difference(DateTime.now());
}
