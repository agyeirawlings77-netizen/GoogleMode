class AiContext {
  final int connectedDevices;
  final bool hasActiveSession;
  final String? activeDeviceName;
  final bool parentalControlsEnabled;
  final bool appLockEnabled;
  const AiContext({this.connectedDevices = 0, this.hasActiveSession = false, this.activeDeviceName, this.parentalControlsEnabled = false, this.appLockEnabled = false});
  String toPromptContext() => 'User context: $connectedDevices device(s) connected, session: $hasActiveSession${activeDeviceName != null ? " ($activeDeviceName)" : ""}, parental controls: $parentalControlsEnabled, app lock: $appLockEnabled.';
}
