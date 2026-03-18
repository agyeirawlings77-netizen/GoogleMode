import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../core/utils/app_logger.dart';

@injectable
class FeedbackService {
  final FirebaseFirestore _db;
  FeedbackService(this._db);

  Future<void> submitFeedback({required String type, required String message, int? rating}) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    await _db.collection('feedback').add({'uid': uid, 'type': type, 'message': message, 'rating': rating, 'ts': FieldValue.serverTimestamp(), 'appVersion': '1.0.0'});
    AppLogger.info('Feedback submitted: $type');
  }

  Future<void> reportBug({required String title, required String description, String? steps}) async {
    await submitFeedback(type: 'bug', message: '$title\n\n$description${steps != null ? "\n\nSteps: $steps" : ""}');
  }

  Future<void> submitRating(int stars, {String? comment}) async {
    await submitFeedback(type: 'rating', message: comment ?? '', rating: stars);
  }
}
