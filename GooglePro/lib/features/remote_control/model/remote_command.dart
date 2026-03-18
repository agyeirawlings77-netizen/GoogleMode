enum RemoteCommandType { touch, key, back, home, recents, volumeUp, volumeDown, powerButton, screenshot, paste, copy, lock, unlock, swipeUp, swipeDown, swipeLeft, swipeRight }

class RemoteCommand {
  final RemoteCommandType type;
  final Map<String, dynamic>? payload;
  final int timestamp;

  const RemoteCommand({required this.type, this.payload, required this.timestamp});

  Map<String, dynamic> toJson() => {'type': type.name, 'payload': payload, 'timestamp': timestamp};
  factory RemoteCommand.fromJson(Map<String, dynamic> j) => RemoteCommand(type: RemoteCommandType.values.firstWhere((t) => t.name == j['type'], orElse: () => RemoteCommandType.touch), payload: j['payload'] as Map<String, dynamic>?, timestamp: j['timestamp'] ?? 0);
}
