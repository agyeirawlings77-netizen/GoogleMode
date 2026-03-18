import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../utils/app_logger.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  static final AppLifecycleObserver _instance = AppLifecycleObserver._();
  factory AppLifecycleObserver() => _instance;
  AppLifecycleObserver._();

  void register() => WidgetsBinding.instance.addObserver(this);
  void unregister() => WidgetsBinding.instance.removeObserver(this);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    AppLogger.debug('AppLifecycle: $state');
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    switch (state) {
      case AppLifecycleState.resumed:
        _updatePresence(uid, true);
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        _updatePresence(uid, false);
        break;
      default:
        break;
    }
  }

  Future<void> _updatePresence(String uid, bool online) async {
    try {
      await FirebaseDatabase.instance.ref('presence/$uid/self').update({
        'online': online,
        'lastSeen': ServerValue.timestamp,
        'appInForeground': online,
      });
    } catch (e) {
      AppLogger.warning('Presence update failed: $e');
    }
  }
}
