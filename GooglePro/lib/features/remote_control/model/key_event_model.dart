enum KeyEventType { keyDown, keyUp, keyPress }

class KeyEventModel {
  final KeyEventType type;
  final int keyCode;
  final String? character;
  final bool ctrl;
  final bool alt;
  final bool shift;
  final int timestamp;

  const KeyEventModel({required this.type, required this.keyCode, this.character, this.ctrl = false, this.alt = false, this.shift = false, required this.timestamp});

  Map<String, dynamic> toJson() => {'type': type.name, 'keyCode': keyCode, 'character': character, 'ctrl': ctrl, 'alt': alt, 'shift': shift, 'timestamp': timestamp};
  factory KeyEventModel.fromJson(Map<String, dynamic> j) => KeyEventModel(type: KeyEventType.values.firstWhere((t) => t.name == j['type'], orElse: () => KeyEventType.keyPress), keyCode: j['keyCode'] ?? 0, character: j['character'], ctrl: j['ctrl'] ?? false, alt: j['alt'] ?? false, shift: j['shift'] ?? false, timestamp: j['timestamp'] ?? 0);
}
