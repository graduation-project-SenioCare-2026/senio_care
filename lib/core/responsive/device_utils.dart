import 'package:flutter/material.dart';
import 'package:senio_care/core/responsive/size_helper.dart';

class DeviceUtils {
  static bool isMobile(BuildContext context) {
    return context.screenWidth < 600;
  }

  static bool isTablet(BuildContext context) {
    return context.screenWidth >= 600 && context.scaleWidth < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return context.scaleWidth >= 1200;
  }

  static T valueDecider<T>(
      BuildContext context, {
        required T onMobile,
        T? onTablet,
        T? onDesktop,
        T? others,
      }) {
    if (isMobile(context)) {
      return onMobile;
    } else if (isDesktop(context) && onDesktop != null) {
      return onDesktop;
    } else if (isTablet(context) && onTablet != null) {
      return onTablet;
    }

    return others ?? onMobile;
  }
}