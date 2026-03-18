class SdpModel {
  final String type; // 'offer' or 'answer'
  final String sdp;
  const SdpModel({required this.type, required this.sdp});
  factory SdpModel.fromJson(Map<String, dynamic> j) => SdpModel(type: j['type'] ?? '', sdp: j['sdp'] ?? '');
  Map<String, dynamic> toJson() => {'type': type, 'sdp': sdp};
}
