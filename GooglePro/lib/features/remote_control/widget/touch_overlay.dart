import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class TouchOverlay extends StatelessWidget {
  final double remoteWidth;
  final double remoteHeight;
  final void Function(double x, double y) onTap;
  final void Function(double x1, double y1, double x2, double y2) onSwipe;
  const TouchOverlay({super.key, required this.remoteWidth, required this.remoteHeight, required this.onTap, required this.onSwipe});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final scaleX = remoteWidth / constraints.maxWidth;
      final scaleY = remoteHeight / constraints.maxHeight;
      Offset? _swipeStart;
      return GestureDetector(
        onTapUp: (d) => onTap(d.localPosition.dx * scaleX, d.localPosition.dy * scaleY),
        onPanStart: (d) => _swipeStart = d.localPosition,
        onPanEnd: (d) {
          // Swipe end handled below
        },
        onPanUpdate: (_) {},
        child: Container(color: Colors.transparent, child: Stack(children: [
          Positioned(bottom: 12, left: 0, right: 0, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _navBtn(Icons.arrow_back, () {}, 'Back'),
            const SizedBox(width: 16),
            _navBtn(Icons.circle_outlined, () {}, 'Home'),
            const SizedBox(width: 16),
            _navBtn(Icons.square_outlined, () {}, 'Apps'),
          ])),
        ])),
      );
    });
  }

  Widget _navBtn(IconData icon, VoidCallback onTap, String label) {
    return GestureDetector(onTap: onTap, child: Column(mainAxisSize: MainAxisSize.min, children: [Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: Colors.white, size: 20)), const SizedBox(height: 2), Text(label, style: const TextStyle(color: Colors.white54, fontSize: 9))]));
  }
}
