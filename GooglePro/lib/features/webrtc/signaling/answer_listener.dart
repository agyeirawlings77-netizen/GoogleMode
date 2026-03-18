import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/app_constants.dart';
@singleton
class AnswerListener {
  StreamSubscription? _sub;
  void Function(Map<String, dynamic>)? onAnswer;
  void start(String uid) {
    _sub?.cancel();
    _sub = FirebaseDatabase.instance.ref('${AppConstants.signalsPath}/$uid/answer').onValue.listen((event) {
      if (!event.snapshot.exists) return;
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null && onAnswer != null) onAnswer!(data.map((k, v) => MapEntry(k.toString(), v)));
    });
  }
  void stop() { _sub?.cancel(); _sub = null; }
}
