class IceCandidateModel {
  final String candidate;
  final String sdpMid;
  final int sdpMLineIndex;
  const IceCandidateModel({required this.candidate, required this.sdpMid, required this.sdpMLineIndex});
  factory IceCandidateModel.fromJson(Map<String, dynamic> j) => IceCandidateModel(candidate: j['candidate'] ?? '', sdpMid: j['sdpMid'] ?? '', sdpMLineIndex: j['sdpMLineIndex'] ?? 0);
  Map<String, dynamic> toJson() => {'candidate': candidate, 'sdpMid': sdpMid, 'sdpMLineIndex': sdpMLineIndex};
}
