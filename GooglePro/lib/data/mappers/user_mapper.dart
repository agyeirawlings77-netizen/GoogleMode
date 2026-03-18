import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';

class UserMapper {
  static UserModel fromFirebase(fb.User u) => UserModel(uid: u.uid, email: u.email ?? '', displayName: u.displayName, photoUrl: u.photoURL, emailVerified: u.emailVerified, phone: u.phoneNumber);
  static UserModel fromJson(Map<String, dynamic> j) => UserModel.fromJson(j);
  static Map<String, dynamic> toFirestore(UserEntity e) => {'uid': e.uid, 'email': e.email, 'displayName': e.displayName, 'photoUrl': e.photoUrl, 'emailVerified': e.emailVerified, 'phone': e.phone, 'isActive': e.isActive, 'fcmToken': e.fcmToken};
}
