import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GpsButton extends StatefulWidget {
  const GpsButton({super.key, required this.onTap});

  final Function() onTap;

  @override
  State<GpsButton> createState() => _GpsButtonState();
}

class _GpsButtonState extends State<GpsButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    initAinmation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void initAinmation() async {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true, min: 0.4);
    _scale = CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 100.w,
          height: 100.h,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.lime,
                blurRadius: 10,
                spreadRadius: 0,
                blurStyle: BlurStyle.outer)
          ], shape: BoxShape.circle, color: Colors.lime),
          child: Icon(Icons.location_on, color: Colors.black, size: 35.w),
        ),
      ),
    );
  }
}
