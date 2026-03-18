import 'dart:typed_data';
class CaptureFrame {
  final Uint8List data;
  final int width;
  final int height;
  final int timestamp;
  const CaptureFrame({required this.data, required this.width, required this.height, required this.timestamp});
  int get sizeBytes => data.lengthInBytes;
}
