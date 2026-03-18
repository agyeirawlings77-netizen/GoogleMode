import 'package:flutter/material.dart';
import '../model/session_model.dart';
import '../../../core/theme/app_theme.dart';
class SessionInfoPanel extends StatelessWidget {
  final SessionModel session;
  const SessionInfoPanel({super.key, required this.session});
  @override
  Widget build(BuildContext context) {
    return Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _row('Session', session.sessionId.substring(0, 8)),
        _row('Role', session.role.name),
        _row('Status', session.status.name),
        _row('Duration', _fmt(session.duration)),
      ]));
  }
  Widget _row(String l, String v) => Padding(padding: const EdgeInsets.only(bottom: 4), child: Row(children: [SizedBox(width: 60, child: Text(l, style: const TextStyle(color: Colors.white54, fontSize: 11))), Text(v, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600))]));
  String _fmt(Duration d) => '${d.inMinutes.toString().padLeft(2,'0')}:${d.inSeconds.remainder(60).toString().padLeft(2,'0')}';
}
