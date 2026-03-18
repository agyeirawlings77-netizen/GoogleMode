import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/security_service.dart';
import '../model/security_settings.dart';
import '../state/security_state.dart';
import '../state/security_event.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  final SecurityService _svc;
  SecurityBloc(this._svc) : super(const SecurityInitial()) {
    on<LoadSecurityDataEvent>(_onLoad);
    on<UpdateSettingsEvent>(_onUpdate);
    on<RunSecurityScanEvent>(_onScan);
    on<MarkAlertReadEvent>(_onMarkRead);
  }

  Future<void> _onLoad(LoadSecurityDataEvent e, Emitter<SecurityState> emit) async {
    emit(const SecurityLoading());
    try {
      final settings = await _svc.loadSettings();
      final alerts = await _svc.getAlerts();
      emit(SecurityLoaded(settings: settings, alerts: alerts));
    } catch (e) { emit(SecurityError(e.toString())); }
  }

  Future<void> _onUpdate(UpdateSettingsEvent e, Emitter<SecurityState> emit) async {
    if (state is! SecurityLoaded) return;
    final s = state as SecurityLoaded;
    final json = s.settings.toJson()..addAll(e.changes);
    final updated = SecuritySettings.fromJson(json);
    await _svc.saveSettings(updated);
    emit(s.copyWith(settings: updated));
    emit(const SecuritySettingsSaved());
    emit(s.copyWith(settings: updated));
  }

  Future<void> _onScan(RunSecurityScanEvent e, Emitter<SecurityState> emit) async {
    if (state is! SecurityLoaded) return;
    final result = await _svc.runSecurityScan();
    emit((state as SecurityLoaded).copyWith(scanResult: result));
  }

  Future<void> _onMarkRead(MarkAlertReadEvent e, Emitter<SecurityState> emit) async {
    await _svc.markAlertRead(e.alertId);
    if (state is SecurityLoaded) {
      final s = state as SecurityLoaded;
      final updated = s.alerts.map((a) => a.alertId == e.alertId ? (a..isRead = true) : a).toList();
      emit(s.copyWith(alerts: updated));
    }
  }
}
