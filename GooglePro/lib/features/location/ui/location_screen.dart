import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../state/location_state.dart';
import '../state/location_event.dart';
import '../viewmodel/location_bloc.dart';
import '../widget/location_info_card.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart';

class LocationScreen extends StatefulWidget {
  final String deviceId;
  final String deviceName;
  const LocationScreen({super.key, required this.deviceId, required this.deviceName});
  @override State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late final LocationBloc _bloc;
  @override void initState() { super.initState(); _bloc = LocationBloc(getIt())..add(LoadLocationEvent(widget.deviceId)); }
  @override void dispose() { _bloc.close(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _bloc,
      child: Scaffold(
        backgroundColor: AppTheme.darkBg,
        appBar: AppBar(title: Text(widget.deviceName, style: const TextStyle(color: AppTheme.darkText, fontWeight: FontWeight.w700)), backgroundColor: AppTheme.darkSurface, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: AppTheme.darkText), onPressed: () => context.pop()),
          actions: [BlocBuilder<LocationBloc, LocationState>(builder: (ctx, state) { final isSharing = state is LocationLoaded && state.isSharing; return TextButton(onPressed: () => _bloc.add(isSharing ? const StopSharingEvent() : const StartSharingEvent()), child: Text(isSharing ? 'Stop' : 'Share', style: TextStyle(color: isSharing ? AppTheme.errorColor : AppTheme.primaryColor, fontWeight: FontWeight.w700))); })],
        ),
        body: BlocBuilder<LocationBloc, LocationState>(builder: (ctx, state) {
          if (state is LocationLoading) return const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor));
          if (state is LocationLoaded) {
            final deviceLoc = state.deviceLocation;
            final myLoc = state.myLocation;
            final center = deviceLoc != null ? LatLng(deviceLoc.latitude, deviceLoc.longitude) : myLoc != null ? LatLng(myLoc.latitude, myLoc.longitude) : const LatLng(6.5244, 3.3792);
            return Column(children: [
              // Map
              Expanded(child: FlutterMap(options: MapOptions(initialCenter: center, initialZoom: 14),
                children: [
                  TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.rawlings.googlepro'),
                  if (deviceLoc != null) MarkerLayer(markers: [Marker(point: LatLng(deviceLoc.latitude, deviceLoc.longitude), width: 40, height: 40, child: Container(decoration: const BoxDecoration(shape: BoxShape.circle, color: AppTheme.errorColor), child: const Icon(Icons.smartphone_rounded, color: Colors.white, size: 22)))]),
                  if (myLoc != null) MarkerLayer(markers: [Marker(point: LatLng(myLoc.latitude, myLoc.longitude), width: 36, height: 36, child: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor, border: Border.all(color: Colors.white, width: 2)), child: const Icon(Icons.person, color: Colors.black, size: 18)))]),
                ])),

              // Info cards
              Padding(padding: const EdgeInsets.all(16), child: Column(children: [
                if (deviceLoc != null) LocationInfoCard(location: deviceLoc, label: '${widget.deviceName} Location', color: AppTheme.errorColor).animate().fadeIn(),
                if (deviceLoc != null) const SizedBox(height: 10),
                if (myLoc != null) LocationInfoCard(location: myLoc, label: 'My Location${state.isSharing ? " (Sharing)" : ""}', color: AppTheme.primaryColor).animate().fadeIn(delay: 100.ms),
                if (deviceLoc == null && myLoc == null) const Center(child: Text('No location data available', style: TextStyle(color: AppTheme.darkSubtext))),
              ])),
            ]);
          }
          if (state is LocationError) return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: AppTheme.errorColor)));
          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
