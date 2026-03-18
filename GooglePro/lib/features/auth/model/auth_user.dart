class AuthUser {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final bool emailVerified;
  final String? phone;
  final String? fcmToken;
  const AuthUser({required this.uid, required this.email, this.displayName, this.photoUrl, this.emailVerified = false, this.phone, this.fcmToken});
  String get firstName => displayName?.split(' ').first ?? email.split('@').first;
  String get initials { if (displayName == null || displayName!.isEmpty) return email[0].toUpperCase(); final p = displayName!.trim().split(' ').where((x) => x.isNotEmpty).toList(); return p.length >= 2 ? '${p[0][0]}${p[1][0]}'.toUpperCase() : p[0][0].toUpperCase(); }
  factory AuthUser.fromFirebase(dynamic u) => AuthUser(uid: u.uid as String, email: u.email as String? ?? '', displayName: u.displayName as String?, photoUrl: u.photoURL as String?, emailVerified: u.emailVerified as bool? ?? false, phone: u.phoneNumber as String?);
  factory AuthUser.fromJson(Map<String, dynamic> j) => AuthUser(uid: j['uid'] ?? '', email: j['email'] ?? '', displayName: j['displayName'], photoUrl: j['photoUrl'], emailVerified: j['emailVerified'] ?? false, phone: j['phone'], fcmToken: j['fcmToken']);
  Map<String, dynamic> toJson() => {'uid': uid, 'email': email, 'displayName': displayName, 'photoUrl': photoUrl, 'emailVerified': emailVerified, 'phone': phone, 'fcmToken': fcmToken};
  AuthUser copyWith({String? displayName, String? fcmToken}) => AuthUser(uid: uid, email: email, displayName: displayName ?? this.displayName, photoUrl: photoUrl, emailVerified: emailVerified, phone: phone, fcmToken: fcmToken ?? this.fcmToken);
}
