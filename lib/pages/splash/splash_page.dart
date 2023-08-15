import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/pages/splash/custom_point.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../../controllers/popular_product_controller.dart';
import '../../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimatoin;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 6000));
    fadingAnimatoin =
        Tween<double>(begin: 1, end: 0.2).animate(animationController!);

    animationController?.repeat(reverse: true);
    Timer(const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeTransition(
              opacity: fadingAnimatoin!,
              child: Center(
                  child: Image.asset("assets/image/splash_view.png",
                      width: Dimensions.splashImg))),
          CoustmIndecator()
        ],
      ),
    );
  }
}
