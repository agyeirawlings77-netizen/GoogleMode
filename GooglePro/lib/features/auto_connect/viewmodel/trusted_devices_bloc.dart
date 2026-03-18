import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/trusted_device_manager.dart';
import '../model/trusted_devices_state.dart';
import '../model/trusted_devices_event.dart';

class TrustedDevicesBloc extends Bloc<TrustedDevicesEvent, TrustedDevicesState> {
  final TrustedDeviceManager _mgr;
  TrustedDevicesBloc(this._mgr) : super(const TrustedDevicesInitial()) {
    on<LoadTrustedDevicesEvent>((e, emit) async { final d = await _mgr.getTrustedDevices(); emit(d.isEmpty ? const TrustedDevicesEmpty() : TrustedDevicesLoaded(d)); });
    on<RemoveTrustedDeviceEvent>((e, emit) async { await _mgr.removeDevice(e.deviceId); add(const LoadTrustedDevicesEvent()); });
    on<ToggleAutoConnectEvent>((e, emit) async { final d = await _mgr.getTrustedDevice(e.deviceId); if (d != null) { await _mgr.saveTrustedDevice(d.copyWith(autoConnect: e.enabled)); add(const LoadTrustedDevicesEvent()); } });
  }
}
