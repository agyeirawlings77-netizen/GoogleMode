enum NotificationType { connection, message, alert, update, location, fileTransfer, system }
enum NotificationPriority { low, normal, high, critical }

class AppNotification {
  final String notificationId;
  final NotificationType type;
  final NotificationPriority priority;
  final String title;
  final String body;
  final String? deviceId;
  final String? deviceName;
  final bool isRead;
  final DateTime timestamp;
  final Map<String, dynamic>? data;

  const AppNotification({required this.notificationId, required this.type, this.priority = NotificationPriority.normal, required this.title, required this.body, this.deviceId, this.deviceName, this.isRead = false, required this.timestamp, this.data});

  factory AppNotification.fromJson(Map<String, dynamic> j) => AppNotification(notificationId: j['notificationId'] ?? '', type: NotificationType.values.firstWhere((t) => t.name == j['type'], orElse: () => NotificationType.system), priority: NotificationPriority.values.firstWhere((p) => p.name == j['priority'], orElse: () => NotificationPriority.normal), title: j['title'] ?? '', body: j['body'] ?? '', deviceId: j['deviceId'], deviceName: j['deviceName'], isRead: j['isRead'] ?? false, timestamp: j['timestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(j['timestamp'] as int) : DateTime.now(), data: j['data'] as Map<String, dynamic>?);

  Map<String, dynamic> toJson() => {'notificationId': notificationId, 'type': type.name, 'priority': priority.name, 'title': title, 'body': body, 'deviceId': deviceId, 'deviceName': deviceName, 'isRead': isRead, 'timestamp': timestamp.millisecondsSinceEpoch, 'data': data};

  AppNotification markRead() => AppNotification(notificationId: notificationId, type: type, priority: priority, title: title, body: body, deviceId: deviceId, deviceName: deviceName, isRead: true, timestamp: timestamp, data: data);
}
