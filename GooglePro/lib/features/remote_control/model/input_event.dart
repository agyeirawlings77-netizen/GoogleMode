enum InputEventType { tap, doubleTap, longPress, swipe, scroll, keyPress, typeText, back, home, appSwitch }

class InputEvent {
  final InputEventType type;
  final double? x;
  final double? y;
  final double? endX;
  final double? endY;
  final String? text;
  final int? keyCode;
  final int timestamp;
  const InputEvent({required this.type, this.x, this.y, this.endX, this.endY, this.text, this.keyCode, required this.timestamp});
  factory InputEvent.tap(double x, double y) => InputEvent(type: InputEventType.tap, x: x, y: y, timestamp: DateTime.now().millisecondsSinceEpoch);
  factory InputEvent.swipe(double x1, double y1, double x2, double y2) => InputEvent(type: InputEventType.swipe, x: x1, y: y1, endX: x2, endY: y2, timestamp: DateTime.now().millisecondsSinceEpoch);
  factory InputEvent.typeText(String text) => InputEvent(type: InputEventType.typeText, text: text, timestamp: DateTime.now().millisecondsSinceEpoch);
  Map<String, dynamic> toJson() => {'type': type.name, 'x': x, 'y': y, 'endX': endX, 'endY': endY, 'text': text, 'keyCode': keyCode, 'ts': timestamp};
  factory InputEvent.fromJson(Map<String, dynamic> j) => InputEvent(type: InputEventType.values.firstWhere((t) => t.name == j['type'], orElse: () => InputEventType.tap), x: (j['x'] as num?)?.toDouble(), y: (j['y'] as num?)?.toDouble(), endX: (j['endX'] as num?)?.toDouble(), endY: (j['endY'] as num?)?.toDouble(), text: j['text'] as String?, keyCode: j['keyCode'] as int?, timestamp: j['ts'] as int? ?? DateTime.now().millisecondsSinceEpoch);
}
