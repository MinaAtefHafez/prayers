import 'package:flutter/material.dart';

extension AssetsImagesEx on String {
  AssetImage imageProv() {
    return AssetImage(this);
  }

  Image image({double? width, double? height, BoxFit? fit}) {
    return Image.asset(
      this,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
    );
  }
}
