import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/trusted_device_repository.dart';
import '../state/trusted_device_state.dart';
import '../state/trusted_device_event.dart';
import '../model/trusted_device_presence.dart';
import '../../../core/utils/app_logger.dart';

class TrustedDeviceBloc extends Bloc<TrustedDeviceEvent, TrustedDeviceState> {
  final TrustedDeviceRepository _repo;
  final Map<String, StreamSubscription> _presenceSubs = {};

  TrustedDeviceBloc(this._repo) : super(const TrustedDeviceInitial()) {
    on<LoadTrustedDevicesEvent>(_onLoad);
    on<SaveTrustedDeviceEvent>(_onSave);
    on<RemoveTrustedDeviceEvent>(_onRemove);
    on<ToggleAutoConnectEvent>(_onToggleAutoConnect);
    on<WatchPresenceEvent>(_onWatchPresence);
    on<PresenceUpdatedEvent>(_onPresenceUpdated);
  }

  Future<void> _onLoad(LoadTrustedDevicesEvent e, Emitter<TrustedDeviceState> emit) async {
    emit(const TrustedDeviceLoading());
    try {
      final devices = await _repo.getAll();
      emit(TrustedDeviceLoaded(devices: devices));
      for (final d in devices) { add(WatchPresenceEvent(d.deviceId, d.ownerUserId)); }
    } catch (e, s) { AppLogger.error('Load trusted devices failed', e, s); emit(TrustedDeviceError(e.toString())); }
  }

  Future<void> _onSave(SaveTrustedDeviceEvent e, Emitter<TrustedDeviceState> emit) async {
    try {
      await _repo.save(e.device);
      final devices = await _repo.getAll();
      final prev = state is TrustedDeviceLoaded ? (state as TrustedDeviceLoaded).presence : <String, TrustedDevicePresence>{};
      emit(TrustedDeviceLoaded(devices: devices, presence: prev));
      emit(const TrustedDeviceSaved());
      emit(TrustedDeviceLoaded(devices: devices, presence: prev));
    } catch (e) { emit(TrustedDeviceError(e.toString())); }
  }

  Future<void> _onRemove(RemoveTrustedDeviceEvent e, Emitter<TrustedDeviceState> emit) async {
    try {
      await _repo.remove(e.deviceId);
      _presenceSubs[e.deviceId]?.cancel();
      _presenceSubs.remove(e.deviceId);
      final devices = await _repo.getAll();
      final prev = state is TrustedDeviceLoaded ? (state as TrustedDeviceLoaded).presence : <String, TrustedDevicePresence>{};
      emit(TrustedDeviceLoaded(devices: devices, presence: prev));
      emit(const TrustedDeviceRemoved());
      emit(TrustedDeviceLoaded(devices: devices, presence: prev));
    } catch (e) { emit(TrustedDeviceError(e.toString())); }
  }

  Future<void> _onToggleAutoConnect(ToggleAutoConnectEvent e, Emitter<TrustedDeviceState> emit) async {
    try {
      await _repo.updateAutoConnect(e.deviceId, e.autoConnect);
      final devices = await _repo.getAll();
      final prev = state is TrustedDeviceLoaded ? (state as TrustedDeviceLoaded).presence : <String, TrustedDevicePresence>{};
      emit(TrustedDeviceLoaded(devices: devices, presence: prev));
    } catch (e) { emit(TrustedDeviceError(e.toString())); }
  }

  Future<void> _onWatchPresence(WatchPresenceEvent e, Emitter<TrustedDeviceState> emit) async {
    _presenceSubs[e.deviceId]?.cancel();
    _presenceSubs[e.deviceId] = _repo.watchOnlineStatus(e.ownerUserId, e.deviceId).listen((online) {
      add(PresenceUpdatedEvent(e.deviceId, online));
    });
  }

  void _onPresenceUpdated(PresenceUpdatedEvent e, Emitter<TrustedDeviceState> emit) {
    if (state is TrustedDeviceLoaded) {
      final s = state as TrustedDeviceLoaded;
      final updated = Map<String, TrustedDevicePresence>.from(s.presence)
        ..[e.deviceId] = TrustedDevicePresence(deviceId: e.deviceId, online: e.online, lastSeen: DateTime.now());
      emit(s.copyWith(presence: updated));
    }
  }

  @override
  Future<void> close() {
    for (final sub in _presenceSubs.values) sub.cancel();
    _presenceSubs.clear();
    return super.close();
  }
}
