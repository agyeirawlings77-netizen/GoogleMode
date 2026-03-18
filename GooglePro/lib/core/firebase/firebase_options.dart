import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_constants.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) throw UnsupportedError('Web not supported');
    switch (defaultTargetPlatform) {
      case TargetPlatform.android: return android;
      case TargetPlatform.iOS: return ios;
      default: throw UnsupportedError('Platform not supported');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: AppConstants.firebaseApiKey,
    appId: AppConstants.firebaseAppId,
    messagingSenderId: AppConstants.firebaseSenderId,
    projectId: AppConstants.firebaseProjectId,
    storageBucket: AppConstants.firebaseStorageBucket,
    databaseURL: AppConstants.firebaseDatabaseUrl,
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: AppConstants.firebaseApiKey,
    appId: '1:458149596472:ios:771af17fbc2a4434ac45cd',
    messagingSenderId: AppConstants.firebaseSenderId,
    projectId: AppConstants.firebaseProjectId,
    storageBucket: AppConstants.firebaseStorageBucket,
    databaseURL: AppConstants.firebaseDatabaseUrl,
    iosClientId: '458149596472-r55k5k5adbac8j9qu6tbrhoo733daqu0.apps.googleusercontent.com',
    iosBundleId: AppConstants.packageName,
  );
}
