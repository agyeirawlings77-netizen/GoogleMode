import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({required super.id, required super.category, required super.title, required super.body, super.isRead, required super.timestamp, super.payload});

  factory NotificationModel.fromJson(Map<String, dynamic> j) => NotificationModel(id: j['id'] ?? '', category: NotificationCategory.values.firstWhere((c) => c.name == j['category'], orElse: () => NotificationCategory.system), title: j['title'] ?? '', body: j['body'] ?? '', isRead: j['isRead'] ?? false, timestamp: j['timestamp'] != null ? DateTime.fromMillisecondsSinceEpoch(j['timestamp'] as int) : DateTime.now(), payload: j['payload'] as Map<String, dynamic>?);

  Map<String, dynamic> toJson() => {'id': id, 'category': category.name, 'title': title, 'body': body, 'isRead': isRead, 'timestamp': timestamp.millisecondsSinceEpoch, 'payload': payload};
}
