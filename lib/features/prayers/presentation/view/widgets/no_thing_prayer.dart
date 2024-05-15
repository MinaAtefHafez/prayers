




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:prayers/core/gen/app_images.dart';

class NothingPrayer extends StatelessWidget {
  const NothingPrayer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 78.w ,
      child: Lottie.asset(Assets.imagesPerson));
  }
}