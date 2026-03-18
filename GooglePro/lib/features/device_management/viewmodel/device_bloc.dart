import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/device_service.dart';
import '../state/device_state.dart';
import '../state/device_event.dart';
import '../../../core/utils/app_logger.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceService _svc;
  StreamSubscription? _sub;

  DeviceBloc(this._svc) : super(const DeviceInitial()) {
    on<LoadDevicesEvent>(_onLoad);
    on<RegisterDeviceEvent>(_onRegister);
    on<DeleteDeviceEvent>(_onDelete);
    on<RenameDeviceEvent>(_onRename);
    on<ToggleTrustDeviceEvent>(_onToggleTrust);
  }

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> _onLoad(LoadDevicesEvent e, Emitter<DeviceState> emit) async {
    emit(const DeviceLoading());
    try {
      final devices = await _svc.getDevices(_uid);
      emit(DeviceLoaded(devices));
      _sub?.cancel();
      _sub = _svc.watchDevices(_uid).listen((devs) {
        if (!isClosed) add(const LoadDevicesEvent());
      });
    } catch (err, s) { AppLogger.error('Devices load failed', err, s); emit(DeviceError(err.toString())); }
  }

  Future<void> _onRegister(RegisterDeviceEvent e, Emitter<DeviceState> emit) async {
    try {
      final device = await _svc.registerThisDevice();
      emit(DeviceRegistered(device));
      add(const LoadDevicesEvent());
    } catch (err) { emit(DeviceError(err.toString())); }
  }

  Future<void> _onDelete(DeleteDeviceEvent e, Emitter<DeviceState> emit) async {
    try {
      await _svc.deleteDevice(e.deviceId);
      emit(const DeviceDeleted());
      add(const LoadDevicesEvent());
    } catch (err) { emit(DeviceError(err.toString())); }
  }

  Future<void> _onRename(RenameDeviceEvent e, Emitter<DeviceState> emit) async {
    try {
      await _svc.renameDevice(e.deviceId, e.name);
      add(const LoadDevicesEvent());
    } catch (err) { emit(DeviceError(err.toString())); }
  }

  void _onToggleTrust(ToggleTrustDeviceEvent e, Emitter<DeviceState> emit) {
    if (state is DeviceLoaded) {
      final devices = (state as DeviceLoaded).devices.map((d) => d.deviceId == e.deviceId ? d.copyWith(isTrusted: e.trusted) : d).toList();
      emit(DeviceLoaded(devices));
    }
  }

  @override Future<void> close() async { await _sub?.cancel(); return super.close(); }
}
