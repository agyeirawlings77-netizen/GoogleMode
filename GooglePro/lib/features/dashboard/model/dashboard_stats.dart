class DashboardStats {
  final int totalDevices;
  final int onlineDevices;
  final int activeSessions;
  final int totalSessions;
  final Duration totalSessionTime;
  final int fileTransfers;
  const DashboardStats({this.totalDevices = 0, this.onlineDevices = 0, this.activeSessions = 0, this.totalSessions = 0, this.totalSessionTime = Duration.zero, this.fileTransfers = 0});
}
