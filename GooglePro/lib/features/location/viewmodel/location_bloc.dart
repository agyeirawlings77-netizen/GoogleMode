import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../service/location_service.dart';
import '../state/location_state.dart';
import '../state/location_event.dart';
import '../../../core/utils/app_logger.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _svc;
  StreamSubscription? _deviceLocSub;
  StreamSubscription? _myLocSub;
  String? _deviceUid;

  LocationBloc(this._svc) : super(const LocationInitial()) {
    on<LoadLocationEvent>(_onLoad);
    on<StartSharingEvent>(_onStartSharing);
    on<StopSharingEvent>(_onStopSharing);
    on<RefreshLocationEvent>((e, emit) async {
      final myLoc = await _svc.getCurrentLocation();
      if (state is LocationLoaded && myLoc != null) emit((state as LocationLoaded).copyWith(myLocation: myLoc));
    });
  }

  Future<void> _onLoad(LoadLocationEvent e, Emitter<LocationState> emit) async {
    _deviceUid = e.deviceUid;
    emit(const LocationLoading());
    try {
      final myLoc = await _svc.getCurrentLocation();
      emit(LocationLoaded(myLocation: myLoc));
      _deviceLocSub?.cancel();
      _deviceLocSub = _svc.watchDeviceLocation(e.deviceUid).listen((loc) {
        if (state is LocationLoaded) emit((state as LocationLoaded).copyWith(deviceLocation: loc));
      });
    } catch (err) { AppLogger.error('Location load failed', err); emit(LocationError(err.toString())); }
  }

  Future<void> _onStartSharing(StartSharingEvent e, Emitter<LocationState> emit) async {
    try {
      await _svc.startSharing();
      if (state is LocationLoaded) emit((state as LocationLoaded).copyWith(isSharing: true));
      _myLocSub = _svc.locationStream.listen((loc) {
        if (state is LocationLoaded) emit((state as LocationLoaded).copyWith(myLocation: loc));
      });
    } catch (err) { emit(LocationError(err.toString())); }
  }

  Future<void> _onStopSharing(StopSharingEvent e, Emitter<LocationState> emit) async {
    await _myLocSub?.cancel();
    await _svc.stopSharing();
    if (state is LocationLoaded) emit((state as LocationLoaded).copyWith(isSharing: false));
  }

  @override Future<void> close() async {
    await _deviceLocSub?.cancel();
    await _myLocSub?.cancel();
    return super.close();
  }
}
