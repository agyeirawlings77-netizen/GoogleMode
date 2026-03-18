import '../model/auth_user.dart';

class UserMapper {
  static Map<String, dynamic> toFirestore(AuthUser user) => {
    'uid': user.uid, 'email': user.email, 'displayName': user.displayName,
    'photoUrl': user.photoUrl, 'phone': user.phone,
  };
  static AuthUser fromFirestore(Map<String, dynamic> data) => AuthUser(
    uid: data['uid'] ?? '', email: data['email'] ?? '',
    displayName: data['displayName'], photoUrl: data['photoUrl'],
    emailVerified: data['emailVerified'] ?? false, phone: data['phone'],
  );
}
