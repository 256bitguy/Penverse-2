import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static EdgeInsets getScreenPadding(BuildContext context) {
    final width = getScreenWidth(context);
    if (width < 600) {
      return const EdgeInsets.all(24);
    } else if (width < 1200) {
      return EdgeInsets.symmetric(
        horizontal: width * 0.1,
        vertical: 32,
      );
    } else {
      return EdgeInsets.symmetric(
        horizontal: width * 0.2,
        vertical: 32,
      );
    }
  }

  static double getFormWidth(BuildContext context) {
    final width = getScreenWidth(context);
    if (width < 600) {
      return width;
    } else if (width < 1200) {
      return 500;
    } else {
      return 600;
    }
  }
}