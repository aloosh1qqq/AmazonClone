import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.441;
  static double pageViewContainer = screenHeight / 3.369;
  static double pageViewTextContainer = screenHeight / 6.509;

  static double height10 = screenHeight / 78.1;
  static double height20 = screenHeight / 39.05;
  static double height15 = screenHeight / 52.07;
  static double height30 = screenHeight / 26.04;
  static double height45 = screenHeight / 17.36;

  static double width10 = screenHeight / 78.1;
  static double width20 = screenHeight / 39.05;
  static double width15 = screenHeight / 52.07;
  static double width30 = screenHeight / 26.04;

  static double font20 = screenHeight / 39.05;
  static double font26 = screenHeight / 30.04;
  static double font16 = screenHeight / 48.82;

  static double radius20 = screenHeight / 39.05;
  static double radius30 = screenHeight / 26.04;
  static double radius15 = screenHeight / 52.07;

  static double iconSize24 = screenHeight / 32.55;
  static double iconSize30 = screenHeight / 30.04;
  static double iconSize16 = screenHeight / 48.82;

  static double listViewImgSize = screenWidth / 3.27;
  static double listViewTextContSize = screenWidth / 3.9;

  static double popularFoodImgSize = screenHeight / 2.232;
  static double bottomHeightBar = screenHeight / 6.51;

  static double splashImg = screenHeight / 3.04;
}

class Responsive extends StatelessWidget {
  const Responsive({
    Key? key,
    required this.desktop,
    this.tablet,
    this.mobileLarge,
    required this.mobile,
  }) : super(key: key);

  final Widget desktop;
  final Widget? tablet;
  final Widget? mobileLarge;
  final Widget mobile;

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width < 1024;
  }

  static bool isMobileLarge(BuildContext context) {
    return MediaQuery.of(context).size.width <= 700;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= 500;
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if (_size.width >= 1024) {
      return desktop;
    } else if (_size.width >= 700 && tablet != null) {
      return tablet!;
    } else if (_size.width >= 450 && mobileLarge != null) {
      return mobileLarge!;
    } else {
      return mobile;
    }
  }
}
