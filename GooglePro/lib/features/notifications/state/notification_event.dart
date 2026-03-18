import 'package:equatable/equatable.dart';
abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override List<Object?> get props => [];
}
class LoadNotificationsEvent extends NotificationEvent { const LoadNotificationsEvent(); }
class MarkNotificationReadEvent extends NotificationEvent {
  final String notificationId;
  const MarkNotificationReadEvent(this.notificationId);
  @override List<Object?> get props => [notificationId];
}
class MarkAllReadEvent extends NotificationEvent { const MarkAllReadEvent(); }
class ClearNotificationsEvent extends NotificationEvent { const ClearNotificationsEvent(); }
class AddNotificationEvent extends NotificationEvent {
  final AppNotification notification;
  const AddNotificationEvent(this.notification);
  @override List<Object?> get props => [notification.notificationId];
}
