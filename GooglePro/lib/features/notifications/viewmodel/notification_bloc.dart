import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/app_notification.dart';
import '../state/notification_state.dart';
import '../state/notification_event.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationInitial()) {
    on<LoadNotificationsEvent>(_onLoad);
    on<MarkNotificationReadEvent>(_onMarkRead);
    on<MarkAllReadEvent>(_onMarkAllRead);
    on<ClearNotificationsEvent>(_onClear);
    on<AddNotificationEvent>(_onAdd);
  }

  void _onLoad(LoadNotificationsEvent e, Emitter<NotificationState> emit) {
    // Demo notifications
    final demo = [
      AppNotification(notificationId: '1', type: NotificationType.connection, title: 'Device Connected', body: 'Samsung Galaxy S24 connected', timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
      AppNotification(notificationId: '2', type: NotificationType.message, title: 'New Message', body: 'You have a new message from Device 2', timestamp: DateTime.now().subtract(const Duration(minutes: 15))),
      AppNotification(notificationId: '3', type: NotificationType.alert, title: 'Security Alert', body: 'Wrong PIN attempt detected', priority: NotificationPriority.high, timestamp: DateTime.now().subtract(const Duration(hours: 1))),
    ];
    emit(NotificationLoaded(notifications: demo, unreadCount: demo.where((n) => !n.isRead).length));
  }

  void _onMarkRead(MarkNotificationReadEvent e, Emitter<NotificationState> emit) {
    if (state is NotificationLoaded) {
      final s = state as NotificationLoaded;
      final updated = s.notifications.map((n) => n.notificationId == e.notificationId ? n.markRead() : n).toList();
      emit(s.copyWith(notifications: updated, unreadCount: updated.where((n) => !n.isRead).length));
    }
  }

  void _onMarkAllRead(MarkAllReadEvent e, Emitter<NotificationState> emit) {
    if (state is NotificationLoaded) {
      final s = state as NotificationLoaded;
      emit(s.copyWith(notifications: s.notifications.map((n) => n.markRead()).toList(), unreadCount: 0));
    }
  }

  void _onClear(ClearNotificationsEvent e, Emitter<NotificationState> emit) =>
    emit(const NotificationLoaded(notifications: [], unreadCount: 0));

  void _onAdd(AddNotificationEvent e, Emitter<NotificationState> emit) {
    final current = state is NotificationLoaded ? (state as NotificationLoaded).notifications : <AppNotification>[];
    final updated = [e.notification, ...current];
    emit(NotificationLoaded(notifications: updated, unreadCount: updated.where((n) => !n.isRead).length));
  }
}
