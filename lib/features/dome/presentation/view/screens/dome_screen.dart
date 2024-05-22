import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prayers/core/dependency_injection/dependency_injection.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';

class DomeScreen extends StatefulWidget {
  const DomeScreen({super.key});

  @override
  State<DomeScreen> createState() => _DomeScreenState();
}

class _DomeScreenState extends State<DomeScreen> {
  final LatLng domeLatLng = const LatLng(21.42250383093481, 39.82619038420518);
  final settingsCubit = di<SettingsCubit>();
  late final CameraPosition _initCameraPosition;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  @override
  void initState() {
    _initCameraPosition = CameraPosition(
        zoom: 7.0,
        target: LatLng(settingsCubit.location!.latitude!,
            settingsCubit.location!.longitude!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initCameraPosition,
        markers: markers,
        polylines: polylines,
        onMapCreated: (controller) {
          final userLocationMarker = Marker(
              markerId: MarkerId(settingsCubit.location!.latitude.toString()),
              position: _initCameraPosition.target);
          final domeMarker = Marker(
              markerId: MarkerId(
                domeLatLng.latitude.toString(),
              ),
              position: domeLatLng);
          markers.addAll([userLocationMarker, domeMarker]);
          polylines.add(Polyline(
            width: 7,
            polylineId: const PolylineId('dome'),
            color: Colors.black,
            points: [_initCameraPosition.target, domeLatLng],
          ));
          setState(() {});
        },
      ),
    );
  }
}
