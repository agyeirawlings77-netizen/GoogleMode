import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../model/security_settings.dart';
import '../model/security_alert.dart';
import '../../../core/utils/app_logger.dart';
import 'package:uuid/uuid.dart';

@singleton
class SecurityService {
  final FirebaseFirestore _firestore;
  final FlutterSecureStorage _storage;
  static const _settingsKey = 'security_settings';

  SecurityService(this._firestore, this._storage);

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<SecuritySettings> loadSettings() async {
    final raw = await _storage.read(key: _settingsKey);
    if (raw == null) return const SecuritySettings();
    try { return SecuritySettings.fromJson(jsonDecode(raw)); } catch (_) { return const SecuritySettings(); }
  }

  Future<void> saveSettings(SecuritySettings s) async {
    await _storage.write(key: _settingsKey, value: jsonEncode(s.toJson()));
    await _firestore.collection('security').doc(_uid).set(s.toJson(), SetOptions(merge: true));
  }

  Future<void> createAlert(AlertType type, AlertSeverity severity, String title, String description) async {
    final alert = SecurityAlert(alertId: const Uuid().v4(), type: type, severity: severity, title: title, description: description, timestamp: DateTime.now());
    await _firestore.collection('security').doc(_uid).collection('alerts').doc(alert.alertId).set(alert.toJson());
    AppLogger.warning('Security alert: $title');
  }

  Future<List<SecurityAlert>> getAlerts() async {
    try {
      final snap = await _firestore.collection('security').doc(_uid).collection('alerts').orderBy('timestamp', descending: true).limit(50).get();
      return snap.docs.map((d) => SecurityAlert.fromJson(d.data())).toList();
    } catch (_) { return []; }
  }

  Future<void> markAlertRead(String alertId) async {
    await _firestore.collection('security').doc(_uid).collection('alerts').doc(alertId).update({'isRead': true});
  }

  Future<Map<String, dynamic>> runSecurityScan() async {
    final issues = <String>[];
    final settings = await loadSettings();
    if (!settings.twoFactorEnabled) issues.add('Two-factor authentication is disabled');
    if (!settings.encryptionEnabled) issues.add('Data encryption is disabled');
    final score = ((1.0 - issues.length * 0.2) * 100).clamp(0, 100).toInt();
    AppLogger.info('Security scan: score=$score issues=${issues.length}');
    return {'score': score, 'issues': issues, 'scannedAt': DateTime.now().toIso8601String()};
  }
}
