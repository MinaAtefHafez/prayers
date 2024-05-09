import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  Future<void> pushNamed(String routeName, {Object? arguments}) async {
    await Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  Future<void> pushNamedReplacement(
    String routeName,
      {Object? arguments}) async {
    await Navigator.pushReplacementNamed(
      this,
      routeName,
      arguments: arguments,
    );
  }

  Future<void> pushNamedRemoveUntil(String routeName,
      {Object? arguments}) async {
    await Navigator.pushNamedAndRemoveUntil(
        this, routeName, arguments: arguments, (route) => false);
  }

  Future<void> pop([int pop = 1]) async {
    for (int i = 0; i < pop; i++) {
      Navigator.pop(this);
    }
  }

  Future<void> popUntil() async {
    Navigator.popUntil(this, (route) => false);
  }
}
