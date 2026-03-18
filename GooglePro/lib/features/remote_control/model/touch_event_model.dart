enum TouchEventType { tap, doubleTap, longPress, swipe, scroll, pinch, drag, dragStart, dragEnd }

class TouchEventModel {
  final TouchEventType type;
  final double x;
  final double y;
  final double? x2;
  final double? y2;
  final double? dx;
  final double? dy;
  final double? scale;
  final int timestamp;

  const TouchEventModel({required this.type, required this.x, required this.y, this.x2, this.y2, this.dx, this.dy, this.scale, required this.timestamp});

  Map<String, dynamic> toJson() => {
    'type': type.name, 'x': x, 'y': y, 'x2': x2, 'y2': y2,
    'dx': dx, 'dy': dy, 'scale': scale, 'timestamp': timestamp,
  };

  factory TouchEventModel.fromJson(Map<String, dynamic> j) => TouchEventModel(
    type: TouchEventType.values.firstWhere((t) => t.name == j['type'], orElse: () => TouchEventType.tap),
    x: (j['x'] ?? 0).toDouble(), y: (j['y'] ?? 0).toDouble(),
    x2: (j['x2'] as num?)?.toDouble(), y2: (j['y2'] as num?)?.toDouble(),
    dx: (j['dx'] as num?)?.toDouble(), dy: (j['dy'] as num?)?.toDouble(),
    scale: (j['scale'] as num?)?.toDouble(),
    timestamp: j['timestamp'] ?? DateTime.now().millisecondsSinceEpoch,
  );
}
