class InputSanitizer {
  static String sanitizeText(String input) => input.trim().replaceAll(RegExp(r'[<>]'), '');
  static String sanitizeHtml(String input) => input.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  static String sanitizeFilename(String input) => input.replaceAll(RegExp(r'[^\w\s\-\.]'), '_').trim();
  static String sanitizePhone(String input) => input.replaceAll(RegExp(r'[^\d\+]'), '');
  static String sanitizeEmail(String input) => input.trim().toLowerCase();
  static String limitLength(String input, int maxLength) => input.length > maxLength ? input.substring(0, maxLength) : input;
  static bool containsXss(String input) => RegExp(r'<script|javascript:|on\w+=', caseSensitive: false).hasMatch(input);
  static bool containsSqlInjection(String input) => RegExp(r"(SELECT|INSERT|UPDATE|DELETE|DROP|UNION|--|;|')", caseSensitive: false).hasMatch(input);
}
