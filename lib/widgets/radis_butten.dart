import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class RadiosButten extends StatefulWidget {
  const RadiosButten({Key? key, this.onTapADD, this.onTapDell, this.onTapEdit})
      : super(key: key);
  final VoidCallback? onTapADD;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDell;
  @override
  State<RadiosButten> createState() => _RadiosButtenState();
}

class _RadiosButtenState extends State<RadiosButten>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  late Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Positioned(
              right: 30,
              bottom: 30,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  IgnorePointer(
                    child: Container(
                      color: Colors.transparent,
                      height: 150.0,
                      width: 150.0,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(270),
                        degOneTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))
                        ..scale(degOneTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: AppColors.iconColor1,
                        width: 50,
                        height: 50,
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onClick: widget.onTapADD,
                        // onClick: () {
                        //   Get.toNamed(RouteHelper.getAddProduct());
                        // },
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(225),
                        degTwoTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))
                        ..scale(degTwoTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CircularButton(
                          color: AppColors.yellowColor,
                          width: 50,
                          height: 50,
                          icon: Icon(
                            Icons.update_outlined,
                            color: Colors.white,
                          ),
                          onClick: widget.onTapEdit),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset.fromDirection(getRadiansFromDegree(180),
                        degThreeTranslationAnimation.value * 100),
                    child: Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(rotationAnimation.value))
                        ..scale(degThreeTranslationAnimation.value),
                      alignment: Alignment.center,
                      child: CircularButton(
                          color: Colors.red,
                          width: 50,
                          height: 50,
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          ),
                          onClick: widget.onTapDell),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.rotationZ(
                        getRadiansFromDegree(rotationAnimation.value)),
                    alignment: Alignment.center,
                    child: CircularButton(
                      color: AppColors.mainColor,
                      width: 60,
                      height: 60,
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onClick: () {
                        if (animationController.isCompleted) {
                          animationController.reverse();
                        } else {
                          animationController.forward();
                        }
                      },
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final Icon? icon;
  final VoidCallback? onClick;

  CircularButton(
      {this.color, this.width, this.height, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon!, enableFeedback: true, onPressed: onClick),
    );
  }
}
