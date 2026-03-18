import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import '../utils/app_logger.dart';

@singleton
class ClipboardService {
  Future<void> copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    AppLogger.debug('Copied to clipboard: ${text.length} chars');
  }

  Future<String?> paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text;
  }

  Future<bool> hasData() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text?.isNotEmpty ?? false;
  }
}
