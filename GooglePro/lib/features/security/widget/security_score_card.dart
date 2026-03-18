import 'package:flutter/material.dart';
import '../model/security_settings.dart';
import '../../../core/theme/app_theme.dart';
class SecurityScoreCard extends StatelessWidget {
  final SecuritySettings settings;
  const SecurityScoreCard({super.key, required this.settings});
  @override
  Widget build(BuildContext context) {
    int score = 50;
    if (settings.biometricEnabled) score += 15;
    if (settings.twoFactorEnabled) score += 15;
    if (settings.encryptionEnabled) score += 10;
    if (settings.intruderPhotoEnabled) score += 5;
    if (settings.wrongPinAlertEnabled) score += 5;
    final c = score >= 80 ? AppTheme.successColor : score >= 60 ? Colors.orange : AppTheme.errorColor;
    return Row(children: [
      SizedBox(width: 60, height: 60, child: Stack(alignment: Alignment.center, children: [
        CircularProgressIndicator(value: score / 100, strokeWidth: 5, backgroundColor: AppTheme.darkBorder, valueColor: AlwaysStoppedAnimation<Color>(c)),
        Text('$score', style: TextStyle(color: c, fontSize: 15, fontWeight: FontWeight.w800)),
      ])),
      const SizedBox(width: 14),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(score >= 80 ? 'Excellent' : score >= 60 ? 'Good' : 'Needs Work', style: TextStyle(color: c, fontSize: 16, fontWeight: FontWeight.w700)),
        const Text('Security Score', style: TextStyle(color: AppTheme.darkSubtext, fontSize: 12)),
      ]),
    ]);
  }
}
