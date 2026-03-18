enum AlertSeverity { low, medium, high, critical }
enum AlertType { unknownDevice, failedLogin, newLocation, suspiciousActivity, permissionChange }

class SecurityAlert {
  final String alertId;
  final AlertType type;
  final AlertSeverity severity;
  final String title;
  final String description;
  final DateTime timestamp;
  bool isRead;
  final Map<String, dynamic>? metadata;

  SecurityAlert({required this.alertId, required this.type, required this.severity, required this.title, required this.description, required this.timestamp, this.isRead = false, this.metadata});
  factory SecurityAlert.fromJson(Map<String, dynamic> j) => SecurityAlert(alertId: j['alertId'] ?? '', type: AlertType.values.firstWhere((t) => t.name == j['type'], orElse: () => AlertType.suspiciousActivity), severity: AlertSeverity.values.firstWhere((s) => s.name == j['severity'], orElse: () => AlertSeverity.medium), title: j['title'] ?? '', description: j['description'] ?? '', timestamp: DateTime.parse(j['timestamp'] ?? DateTime.now().toIso8601String()), isRead: j['isRead'] ?? false);
  Map<String, dynamic> toJson() => {'alertId': alertId, 'type': type.name, 'severity': severity.name, 'title': title, 'description': description, 'timestamp': timestamp.toIso8601String(), 'isRead': isRead};
}
