import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../model/auth_user.dart';

class AuthMapper {
  static AuthUser fromFirebase(fb.User user) => AuthUser(
    uid: user.uid, email: user.email ?? '',
    displayName: user.displayName, photoUrl: user.photoURL,
    emailVerified: user.emailVerified, phone: user.phoneNumber,
  );
}
