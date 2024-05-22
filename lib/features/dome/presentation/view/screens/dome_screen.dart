import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prayers/core/dependency_injection/dependency_injection.dart';
import 'package:prayers/core/extensions/assets_images.dart';
import 'package:prayers/core/gen/app_images.dart';
import 'package:prayers/features/settings_details/presentation/settings_cubit/settings_cubit.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

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
        onMapCreated: (controller) async {
          final userLocationMarker = Marker(
              markerId: MarkerId(settingsCubit.location!.latitude.toString()),
              position: _initCameraPosition.target);
          final kaabaMarker = await Assets.imagesKaaba
              .image(width: 200.w, height: 200.h)
              .toBitmapDescriptor();

          final domeMarker = Marker(
              markerId: MarkerId(
                domeLatLng.latitude.toString(),
              ),
              infoWindow: InfoWindow(title: tr('Kaaba')),
              icon: kaabaMarker,
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
