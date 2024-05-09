import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.boxShape});

  final double width;
  final double height;
  final BoxShape boxShape;
  const ShimmerWidget.rectangular(
      {super.key, required this.width, required this.height})
      : boxShape = BoxShape.rectangle;
  const ShimmerWidget.cirular(
      {super.key, required this.width, required this.height})
      : boxShape = BoxShape.circle;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            shape: boxShape,
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade300),
      ),
    );
  }
}
