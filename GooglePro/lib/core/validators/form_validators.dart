class FormValidators {
  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w.+-]+@[\w-]+\.[\w.]+$').hasMatch(v.trim())) return 'Enter a valid email';
    return null;
  }
  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 8) return 'Min 8 characters';
    if (!v.contains(RegExp(r'[A-Z]'))) return 'Must contain uppercase letter';
    if (!v.contains(RegExp(r'[0-9]'))) return 'Must contain a number';
    return null;
  }
  static String? confirmPassword(String? v, String original) {
    if (v == null || v.isEmpty) return 'Please confirm password';
    if (v != original) return 'Passwords do not match';
    return null;
  }
  static String? pin(String? v) {
    if (v == null || v.isEmpty) return 'PIN is required';
    if (v.length < 4 || v.length > 6) return 'PIN must be 4–6 digits';
    if (!RegExp(r'^[0-9]+$').hasMatch(v)) return 'PIN must be numeric';
    return null;
  }
  static String? name(String? v) {
    if (v == null || v.trim().isEmpty) return 'Name is required';
    if (v.trim().length < 2) return 'Min 2 characters';
    if (v.trim().length > 50) return 'Max 50 characters';
    return null;
  }
  static String? phone(String? v) {
    if (v == null || v.trim().isEmpty) return 'Phone number is required';
    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(v.trim())) return 'Enter a valid phone number';
    return null;
  }
  static String? required(String? v) => (v == null || v.trim().isEmpty) ? 'This field is required' : null;
}
