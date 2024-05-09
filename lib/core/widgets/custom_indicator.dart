import 'package:flutter/material.dart';
import 'package:prayers/core/theme/colors/colors.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: AppColors.primary,
      child: CircularProgressIndicator(
        color: color ?? Colors.white,
        backgroundColor: Colors.grey.shade300,
      ),
    );
  }
}
