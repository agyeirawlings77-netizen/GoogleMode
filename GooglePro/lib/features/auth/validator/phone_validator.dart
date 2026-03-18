class PhoneValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    final clean = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (clean.length < 10 || clean.length > 15) return 'Enter a valid phone number';
    if (!RegExp(r'^\+?[0-9]+$').hasMatch(clean)) return 'Phone number must contain only digits';
    return null;
  }
}
