import 'package:flutter/widgets.dart';
import '../utils/app_logger.dart';

mixin LifecycleMixin<T extends StatefulWidget> on State<T>, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    AppLogger.debug('AppLifecycle: $state');
    switch (state) {
      case AppLifecycleState.resumed: onAppResumed(); break;
      case AppLifecycleState.paused: onAppPaused(); break;
      case AppLifecycleState.inactive: onAppInactive(); break;
      case AppLifecycleState.detached: onAppDetached(); break;
      default: break;
    }
  }

  void onAppResumed() {}
  void onAppPaused() {}
  void onAppInactive() {}
  void onAppDetached() {}
}
