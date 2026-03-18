class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String? phone;
  const RegisterRequest({required this.name, required this.email, required this.password, this.phone});
  Map<String, dynamic> toJson() => {'name': name, 'email': email, 'password': password, 'phone': phone};
}
