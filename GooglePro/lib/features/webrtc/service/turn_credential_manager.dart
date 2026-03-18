import 'package:injectable/injectable.dart';
import '../model/webrtc_config.dart';
import '../../../core/constants/app_constants.dart';
@singleton
class TurnCredentialManager {
  Map<String, dynamic> get currentConfig => WebRtcConfig.iceServers;
  String get turnUrl => AppConstants.turnUrl;
  String get turnUsername => AppConstants.turnUsername;
  String get turnPassword => AppConstants.turnPassword;
  String get stunUrl => AppConstants.stunUrl;
  bool get hasCredentials => turnUsername.isNotEmpty && turnPassword.isNotEmpty;
}
