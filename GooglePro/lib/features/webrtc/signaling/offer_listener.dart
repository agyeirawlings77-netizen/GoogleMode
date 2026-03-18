import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';

@singleton
class OfferListener {
  StreamSubscription? _sub;
  void Function(Map<String, dynamic>)? onOffer;

  void start(String uid) {
    _sub?.cancel();
    _sub = FirebaseDatabase.instance.ref('${AppConstants.signalsPath}/$uid/offer').onValue.listen((event) {
      if (!event.snapshot.exists) return;
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null && onOffer != null) {
        onOffer!(data.map((k, v) => MapEntry(k.toString(), v)));
        AppLogger.info('Offer received for $uid');
      }
    });
  }

  void stop() { _sub?.cancel(); _sub = null; }
}
