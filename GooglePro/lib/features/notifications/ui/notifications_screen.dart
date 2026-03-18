import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../state/notification_state.dart';
import '../state/notification_event.dart';
import '../viewmodel/notification_bloc.dart';
import '../widget/notification_tile.dart';
import '../../../core/theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationBloc()..add(const LoadNotificationsEvent()),
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(
          title: const Text('Notifications', style: TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)),
          backgroundColor: AppTheme.darkSurface, elevation: 0,
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop()),
          actions: [
            BlocBuilder<NotificationBloc, NotificationState>(builder: (ctx, state) {
              if (state is NotificationLoaded && state.unreadCount > 0) return TextButton(onPressed: () => ctx.read<NotificationBloc>().add(const MarkAllReadEvent()), child: const Text('Mark all read', style: TextStyle(color: AppTheme.primaryColor, fontSize: 13)));
              return const SizedBox.shrink();
            }),
          ],
        ),
        body: BlocBuilder<NotificationBloc, NotificationState>(builder: (ctx, state) {
          if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.notifications_none, color: AppTheme.darkSubtext, size: 56).animate().scale(),
              const SizedBox(height: 16),
              const Text('No notifications', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 15)),
            ]));
            return ListView.builder(padding: const EdgeInsets.all(16), itemCount: state.notifications.length, itemBuilder: (ctx, i) =>
              NotificationTile(notification: state.notifications[i], onTap: () => ctx.read<NotificationBloc>().add(MarkNotificationReadEvent(state.notifications[i].notificationId)))
              .animate().fadeIn(delay: Duration(milliseconds: i * 50)).slideX(begin: 0.05));
          }
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
