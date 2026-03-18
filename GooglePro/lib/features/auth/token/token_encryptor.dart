import 'dart:convert';
import 'package:crypto/crypto.dart';

class TokenEncryptor {
  static String hash(String value) {
    final bytes = utf8.encode(value);
    return sha256.convert(bytes).toString();
  }
  static bool verify(String value, String hash) => TokenEncryptor.hash(value) == hash;
}
