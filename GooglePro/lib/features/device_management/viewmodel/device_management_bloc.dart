import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../repository/device_repository.dart';
import '../model/device_model.dart';
import '../model/qr_pair_model.dart';
import '../state/device_management_state.dart';
import '../state/device_management_event.dart';
import '../../trusted_device/model/trusted_device_model.dart';
import '../../trusted_device/repository/trusted_device_repository.dart';
import '../../../core/utils/app_logger.dart';

class DeviceManagementBloc extends Bloc<DeviceManagementEvent, DeviceManagementState> {
  final DeviceRepository _deviceRepo;
  final TrustedDeviceRepository _trustedRepo;
  DeviceManagementBloc(this._deviceRepo, this._trustedRepo) : super(const DeviceManagementInitial()) {
    on<LoadDevicesEvent>(_onLoad);
    on<RegisterThisDeviceEvent>(_onRegister);
    on<GenerateQrCodeEvent>(_onGenerateQr);
    on<ScanQrCodeEvent>(_onScanQr);
    on<RemoveDeviceEvent>(_onRemove);
    on<RenameDeviceEvent>(_onRename);
  }

  Future<void> _onLoad(LoadDevicesEvent e, Emitter<DeviceManagementState> emit) async {
    emit(const DeviceManagementLoading());
    try {
      final devices = await _deviceRepo.getDevices();
      final thisDevice = await _deviceRepo.getThisDevice();
      emit(DevicesLoaded(devices: devices, thisDevice: thisDevice));
    } catch (e, s) { AppLogger.error('Load devices failed', e, s); emit(DeviceManagementError(e.toString())); }
  }

  Future<void> _onRegister(RegisterThisDeviceEvent e, Emitter<DeviceManagementState> emit) async {
    emit(const DeviceManagementLoading());
    try {
      final device = await _deviceRepo.getThisDevice();
      if (device != null) await _deviceRepo.registerDevice(device);
      emit(const DeviceRegistered());
      add(const LoadDevicesEvent());
    } catch (e) { emit(DeviceManagementError(e.toString())); }
  }

  Future<void> _onGenerateQr(GenerateQrCodeEvent e, Emitter<DeviceManagementState> emit) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
      final device = await _deviceRepo.getThisDevice();
      final qr = QrPairModel(deviceId: device?.deviceId ?? const Uuid().v4(), ownerUserId: uid, deviceName: device?.deviceName ?? 'My Device', deviceType: device?.deviceType ?? 'phone', fcmToken: device?.fcmToken, timestamp: DateTime.now().millisecondsSinceEpoch);
      emit(QrCodeGenerated(qr.toQrString()));
    } catch (e) { emit(DeviceManagementError(e.toString())); }
  }

  Future<void> _onScanQr(ScanQrCodeEvent e, Emitter<DeviceManagementState> emit) async {
    try {
      final qr = QrPairModel.fromQrString(e.qrData);
      if (qr == null) { emit(const DeviceManagementError('Invalid QR code')); return; }
      if (qr.isExpired) { emit(const DeviceManagementError('QR code has expired')); return; }
      final device = DeviceModel(deviceId: qr.deviceId, deviceName: qr.deviceName, deviceType: qr.deviceType, ownerUserId: qr.ownerUserId, fcmToken: qr.fcmToken);
      await _trustedRepo.save(TrustedDeviceModel(deviceId: qr.deviceId, deviceName: qr.deviceName, deviceType: qr.deviceType, ownerUserId: qr.ownerUserId, fcmToken: qr.fcmToken, savedAt: DateTime.now(), lastConnectedAt: DateTime.now()));
      emit(DevicePaired(device));
    } catch (e) { emit(DeviceManagementError(e.toString())); }
  }

  Future<void> _onRemove(RemoveDeviceEvent e, Emitter<DeviceManagementState> emit) async {
    try { await _deviceRepo.removeDevice(e.deviceId); add(const LoadDevicesEvent()); }
    catch (e) { emit(DeviceManagementError(e.toString())); }
  }

  Future<void> _onRename(RenameDeviceEvent e, Emitter<DeviceManagementState> emit) async {
    try { await _deviceRepo.renameDevice(e.deviceId, e.newName); add(const LoadDevicesEvent()); }
    catch (e) { emit(DeviceManagementError(e.toString())); }
  }
}
