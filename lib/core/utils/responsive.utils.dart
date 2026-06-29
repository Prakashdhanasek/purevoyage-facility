// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Responsive {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static late double textScaleFactor;
  static late double devicePixelRatio;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    textScaleFactor = _mediaQueryData.textScaleFactor;
    devicePixelRatio = _mediaQueryData.devicePixelRatio;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 650;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 650 &&
        MediaQuery.of(context).size.width < 1100;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1100;
  }

  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    } else {
      return mobile;
    }
  }

  static double responsiveFontSize(
    BuildContext context, {
    required double fontSize,
  }) {
    const double designWidth = 375;

    double currentWidth = MediaQuery.of(context).size.width;

    double scaleFactor = currentWidth / designWidth;
    if (scaleFactor < 0.8) scaleFactor = 0.8;
    if (scaleFactor > 1.4) scaleFactor = 1.4;

    return fontSize * scaleFactor;
  }

  static double hp(double percentage) {
    return blockSizeVertical * percentage;
  }

  static double wp(double percentage) {
    return blockSizeHorizontal * percentage;
  }

  static double safeHp(double percentage) {
    return safeBlockVertical * percentage;
  }

  static double safeWp(double percentage) {
    return safeBlockHorizontal * percentage;
  }
}
