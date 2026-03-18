import 'package:flutter/material.dart';
import '../model/touch_event_model.dart';

class RemoteTouchSurface extends StatelessWidget {
  final Widget child;
  final void Function(TouchEventModel) onTouch;
  final double scaleX;
  final double scaleY;

  const RemoteTouchSurface({super.key, required this.child, required this.onTouch, this.scaleX = 1.0, this.scaleY = 1.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (d) => onTouch(TouchEventModel(type: TouchEventType.tap, x: d.localPosition.dx * scaleX, y: d.localPosition.dy * scaleY, timestamp: _now)),
      onDoubleTapDown: (d) => onTouch(TouchEventModel(type: TouchEventType.doubleTap, x: d.localPosition.dx * scaleX, y: d.localPosition.dy * scaleY, timestamp: _now)),
      onLongPressStart: (d) => onTouch(TouchEventModel(type: TouchEventType.longPress, x: d.localPosition.dx * scaleX, y: d.localPosition.dy * scaleY, timestamp: _now)),
      onPanStart: (d) => onTouch(TouchEventModel(type: TouchEventType.dragStart, x: d.localPosition.dx * scaleX, y: d.localPosition.dy * scaleY, timestamp: _now)),
      onPanUpdate: (d) => onTouch(TouchEventModel(type: TouchEventType.drag, x: d.localPosition.dx * scaleX, y: d.localPosition.dy * scaleY, dx: d.delta.dx * scaleX, dy: d.delta.dy * scaleY, timestamp: _now)),
      onPanEnd: (d) => onTouch(TouchEventModel(type: TouchEventType.dragEnd, x: 0, y: 0, timestamp: _now)),
      child: child,
    );
  }

  int get _now => DateTime.now().millisecondsSinceEpoch;
}
