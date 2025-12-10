import 'package:flutter/material.dart';

class ResponsiveHelper {
  static late double _screenWidth;

  static void init(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
  }

  static double getValue({
    double? thinValue,
    required double extraSmallValue,
    required double smallValue,
    required double mediumValue,
    required double largeValue,
    double? extraLargeValue,
  }) {
    if (_screenWidth <= 393) {
      return thinValue ?? extraSmallValue;
    } else if (_screenWidth <= 450) {
      return extraSmallValue;
    } else if (_screenWidth <= 600) {
      return smallValue;
    } else if (_screenWidth <= 900) {
      return mediumValue;
    } else if (_screenWidth <= 1200) {
      return largeValue;
    } else {
      return extraLargeValue ?? largeValue;
    }
  }
}
