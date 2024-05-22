import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayers/core/extensions/assets_images.dart';
import 'package:prayers/core/gen/app_images.dart';
import 'package:prayers/core/helpers/permissions_helper/permissions.dart';
import 'package:prayers/core/theme/colors/colors.dart';
import 'dart:math' as math;

import 'package:prayers/core/widgets/error_widget.dart';

class CompassScreen extends StatefulWidget {
  const CompassScreen({super.key});

  @override
  State<CompassScreen> createState() => _CompassScreenState();
}

class _CompassScreenState extends State<CompassScreen> {
  bool isPermissionLocationGranted = false;
  @override
  void initState() {
    super.initState();
    _fetchPermission();
  }

  void _fetchPermission() async {
    isPermissionLocationGranted = await PermissionsHelper.locationPermission();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(80.w),
        child: _buildCompass(),
      ),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CustomErrorWidget(message: snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: CustomErrorWidget(message: 'Device does not have sensors !'),
          );
        }

        if (isPermissionLocationGranted) {
          return Transform.rotate(
            angle: (direction * (math.pi / 180) * -1),
            child: Assets.imagesCompass.image(),
          );
        } else {
          return const CustomErrorWidget(
              message: 'location permission is needed !');
        }
      },
    );
  }
}
