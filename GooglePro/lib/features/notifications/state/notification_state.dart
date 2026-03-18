import 'package:equatable/equatable.dart';
import '../model/app_notification.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
  @override List<Object?> get props => [];
}
class NotificationInitial extends NotificationState { const NotificationInitial(); }
class NotificationLoaded extends NotificationState {
  final List<AppNotification> notifications;
  final int unreadCount;
  const NotificationLoaded({required this.notifications, this.unreadCount = 0});
  @override List<Object?> get props => [notifications, unreadCount];
  NotificationLoaded copyWith({List<AppNotification>? notifications, int? unreadCount}) =>
    NotificationLoaded(notifications: notifications ?? this.notifications, unreadCount: unreadCount ?? this.unreadCount);
}
class NotificationError extends NotificationState {
  final String message;
  const NotificationError(this.message);
  @override List<Object?> get props => [message];
}
