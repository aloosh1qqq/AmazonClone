import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/home/main_product_page.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/widgets/user_widget.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppColumn extends StatefulWidget {
  final String text;
  final String cpu;
  final String gpu;
  final String? userName;
  final String? userImage;
  final String catigory;
  final String? discription;

  final double? avgRating;
  const AppColumn(
      {Key? key,
      required this.text,
      required this.cpu,
      required this.gpu,
      this.userImage,
      this.userName,
      required this.catigory,
      this.discription,
      this.avgRating})
      : super(key: key);

  @override
  State<AppColumn> createState() => _AppColumnState();
}

class _AppColumnState extends State<AppColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BigText(text: widget.text, size: Dimensions.font26),
            UserWidget(
              name: widget.userName,
              image: widget.userImage,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.height10 / 4,
        ),
        RatingBarIndicator(
          itemSize: 30,
          rating: widget.avgRating!,
          direction: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, _) => const Icon(
            Icons.star_rounded,
            color: Colors.amberAccent,
          ),
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        widget.catigory == 'laptop' || widget.catigory == 'computer'
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconAndTextWidget(
                      icon: SizedBox(
                        child: Image.asset('assets/icons/cpu.png'),
                        height: Dimensions.iconSize24,
                      ),
                      text: widget.cpu,
                      iconColor: AppColors.iconColor1),
                  IconAndTextWidget(
                      icon: SizedBox(
                        child: Image.asset('assets/icons/gpu_icon.png'),
                        height: Dimensions.iconSize24,
                      ),
                      text: widget.gpu,
                      iconColor: AppColors.iconColor2),
                ],
              )
            : BigText(
                text: widget.discription.toString(),
                color: AppColors.textColor,
              )
      ],
    );
  }
}
