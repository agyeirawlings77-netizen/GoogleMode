import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/parental_repository.dart';
import '../state/parental_state.dart';
import '../state/parental_event.dart';
import '../model/app_usage_rule.dart';
import '../../../core/utils/app_logger.dart';

class ParentalBloc extends Bloc<ParentalEvent, ParentalState> {
  final ParentalRepository _repo;
  ParentalBloc(this._repo) : super(const ParentalInitial()) {
    on<LoadParentalDataEvent>(_onLoad);
    on<SaveProfileEvent>(_onSaveProfile);
    on<AddRuleEvent>(_onAddRule);
    on<ToggleRuleEvent>(_onToggleRule);
    on<RemoveRuleEvent>(_onRemoveRule);
    on<UpdateScreenLimitEvent>(_onUpdateLimit);
    on<LockDeviceEvent>(_onLockDevice);
  }

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> _onLoad(LoadParentalDataEvent e, Emitter<ParentalState> emit) async {
    emit(const ParentalLoading());
    try {
      final profile = await _repo.loadProfile(_uid, e.deviceId);
      final screenTime = await _repo.getTodayScreenTime(e.deviceId);
      final rules = await _repo.loadRules(_uid);
      emit(ParentalLoaded(profile: profile, todayScreenTime: screenTime, rules: rules));
    } catch (e, s) { AppLogger.error('Load parental failed', e, s); emit(ParentalError(e.toString())); }
  }

  Future<void> _onSaveProfile(SaveProfileEvent e, Emitter<ParentalState> emit) async {
    try {
      await _repo.saveProfile(e.profile);
      emit(const ParentalProfileSaved());
      add(LoadParentalDataEvent(e.profile.childDeviceId));
    } catch (e) { emit(ParentalError(e.toString())); }
  }

  Future<void> _onAddRule(AddRuleEvent e, Emitter<ParentalState> emit) async {
    try {
      await _repo.saveRule(_uid, e.rule);
      emit(const ParentalRuleSaved());
      if (state is ParentalLoaded) {
        final s = state as ParentalLoaded;
        emit(s.copyWith(rules: [...s.rules, e.rule]));
      }
    } catch (e) { emit(ParentalError(e.toString())); }
  }

  Future<void> _onToggleRule(ToggleRuleEvent e, Emitter<ParentalState> emit) async {
    if (state is! ParentalLoaded) return;
    final s = state as ParentalLoaded;
    final updated = s.rules.map((r) => r.ruleId == e.ruleId ? r.copyWith(isBlocked: e.isBlocked) : r).toList();
    emit(s.copyWith(rules: updated));
    final rule = updated.firstWhere((r) => r.ruleId == e.ruleId);
    await _repo.saveRule(_uid, rule);
  }

  Future<void> _onRemoveRule(RemoveRuleEvent e, Emitter<ParentalState> emit) async {
    await _repo.deleteRule(_uid, e.ruleId);
    if (state is ParentalLoaded) {
      final s = state as ParentalLoaded;
      emit(s.copyWith(rules: s.rules.where((r) => r.ruleId != e.ruleId).toList()));
    }
  }

  Future<void> _onUpdateLimit(UpdateScreenLimitEvent e, Emitter<ParentalState> emit) async {
    if (state is ParentalLoaded) {
      final s = state as ParentalLoaded;
      if (s.profile != null) {
        final updated = s.profile!.copyWith(dailyScreenLimitMinutes: e.minutes);
        await _repo.saveProfile(updated);
        emit(s.copyWith(profile: updated));
      }
    }
  }

  Future<void> _onLockDevice(LockDeviceEvent e, Emitter<ParentalState> emit) async {
    await _repo.lockDevice(e.targetDeviceId);
  }
}
