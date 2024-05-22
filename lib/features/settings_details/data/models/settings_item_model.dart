import 'package:flutter/material.dart';

class SettingsItemModel {
  final String title;
  final String subTitle;
  final IconData? iconData;

  SettingsItemModel(
      {required this.title, required this.subTitle,  this.iconData});
}
