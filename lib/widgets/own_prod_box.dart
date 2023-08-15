import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class OwnProd extends StatefulWidget {
  OwnProd(
      {Key? key,
      required this.data,
      this.isSelected = true,
      this.onTap,
      this.selectedColor = Colors.deepPurpleAccent})
      : super(key: key);
  final ProductModel data;
  final Color selectedColor;
  final bool isSelected;
  final GestureTapCallback? onTap;

  @override
  State<OwnProd> createState() => _OwnProd();
}

class _OwnProd extends State<OwnProd> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: widget.isSelected ? AppColors.mainColor : Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                        widget.data.images[0],
                      ),
                      fit: BoxFit.cover)),
              height: Dimensions.height15 * 8,
              // child: Image.network(
              //   widget.data.images[0],
              //   fit: BoxFit.scaleDown,
              // )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(
                  text: widget.data.name.toString(),
                ),
                SmallText(
                  text: widget.data.price.toString() + " S.P",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
