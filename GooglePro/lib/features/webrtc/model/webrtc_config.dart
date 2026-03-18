import '../../../core/constants/app_constants.dart';

class WebRtcConfig {
  static Map<String, dynamic> get iceServers => {
    'iceServers': [
      {'urls': AppConstants.stunUrl},
      {'urls': AppConstants.turnUrl, 'username': AppConstants.turnUsername, 'credential': AppConstants.turnPassword},
      {'urls': 'turn:relay.metered.ca:443', 'username': AppConstants.turnUsername, 'credential': AppConstants.turnPassword},
      {'urls': 'turn:relay.metered.ca:443?transport=tcp', 'username': AppConstants.turnUsername, 'credential': AppConstants.turnPassword},
    ],
    'iceCandidatePoolSize': 10,
  };
  static const Map<String, dynamic> sdpConstraints = {'mandatory': {'OfferToReceiveAudio': true, 'OfferToReceiveVideo': true}, 'optional': []};
  static const Map<String, dynamic> audioConstraints = {'mandatory': {}, 'optional': [{'googNoiseSuppression': true}, {'googEchoCancellation': true}]};
  static Map<String, dynamic> encodingParams({int maxBitrate = 2000000, int maxFramerate = 15}) => {'maxBitrate': maxBitrate, 'maxFramerate': maxFramerate, 'scaleResolutionDownBy': maxBitrate < 500000 ? 2.0 : 1.0};
}
