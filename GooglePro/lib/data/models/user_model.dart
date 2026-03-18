import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.uid, required super.email, super.displayName, super.photoUrl, super.emailVerified, super.phone, super.createdAt, super.isActive, super.fcmToken});

  factory UserModel.fromJson(Map<String, dynamic> j) => UserModel(uid: j['uid'] ?? '', email: j['email'] ?? '', displayName: j['displayName'], photoUrl: j['photoUrl'] ?? j['photoURL'], emailVerified: j['emailVerified'] ?? false, phone: j['phone'], createdAt: j['createdAt'] != null ? (j['createdAt'] is String ? DateTime.tryParse(j['createdAt']) : null) : null, isActive: j['isActive'] ?? true, fcmToken: j['fcmToken']);

  factory UserModel.fromFirebase(dynamic user) => UserModel(uid: user.uid, email: user.email ?? '', displayName: user.displayName, photoUrl: user.photoURL, emailVerified: user.emailVerified ?? false, phone: user.phoneNumber);

  Map<String, dynamic> toJson() => {'uid': uid, 'email': email, 'displayName': displayName, 'photoUrl': photoUrl, 'emailVerified': emailVerified, 'phone': phone, 'createdAt': createdAt?.toIso8601String(), 'isActive': isActive, 'fcmToken': fcmToken};

  UserModel copyWith({String? uid, String? email, String? displayName, String? photoUrl, bool? emailVerified, String? phone, String? fcmToken, bool? isActive}) =>
    UserModel(uid: uid ?? this.uid, email: email ?? this.email, displayName: displayName ?? this.displayName, photoUrl: photoUrl ?? this.photoUrl, emailVerified: emailVerified ?? this.emailVerified, phone: phone ?? this.phone, fcmToken: fcmToken ?? this.fcmToken, isActive: isActive ?? this.isActive, createdAt: createdAt);
}
