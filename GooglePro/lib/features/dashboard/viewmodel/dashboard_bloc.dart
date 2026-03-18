import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../device_management/service/device_service.dart';
import '../../device_management/model/device_model_local.dart';
import '../model/dashboard_stats.dart';
import '../state/dashboard_state.dart';
import '../state/dashboard_event.dart';
import '../../../core/utils/app_logger.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DeviceService _deviceSvc;
  StreamSubscription? _devicesSub;
  List<DeviceModelLocal> _devices = [];

  DashboardBloc(this._deviceSvc) : super(const DashboardInitial()) {
    on<LoadDashboardEvent>(_onLoad);
    on<RefreshDashboardEvent>(_onRefresh);
    on<DeviceStatusChangedEvent>(_onStatusChanged);
  }

  String get _uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> _onLoad(LoadDashboardEvent e, Emitter<DashboardState> emit) async {
    emit(const DashboardLoading());
    try {
      _devices = await _deviceSvc.getDevices(_uid);
      _emitLoaded(emit);
      _devicesSub?.cancel();
      _devicesSub = _deviceSvc.watchDevices(_uid).listen((devices) {
        _devices = devices;
        if (state is! DashboardInitial) add(const RefreshDashboardEvent());
      });
    } catch (e, s) {
      AppLogger.error('Dashboard load failed', e, s);
      emit(DashboardError(e.toString()));
    }
  }

  void _onRefresh(RefreshDashboardEvent e, Emitter<DashboardState> emit) => _emitLoaded(emit);

  void _onStatusChanged(DeviceStatusChangedEvent e, Emitter<DashboardState> emit) {
    _devices = _devices.map((d) => d.deviceId == e.deviceId ? d.copyWith(isOnline: e.isOnline) : d).toList();
    _emitLoaded(emit);
  }

  void _emitLoaded(Emitter<DashboardState> emit) {
    final online = _devices.where((d) => d.isOnline).length;
    emit(DashboardLoaded(devices: _devices, stats: DashboardStats(totalDevices: _devices.length, onlineDevices: online)));
  }

  @override Future<void> close() async { await _devicesSub?.cancel(); return super.close(); }
}
