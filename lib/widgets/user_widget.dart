import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class UserWidget extends StatefulWidget {
  String? name;
  String? image;
  UserWidget({Key? key, this.image, this.name}) : super(key: key);

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.width30 * 4,
      height: Dimensions.height20 * 1.5,
      child: Row(
        children: [
          Container(
            width: Dimensions.width30,
            height: Dimensions.height30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: NetworkImage(
                  widget.image.toString(),
                ),
              ),
            ),
          ),
          SizedBox(width: Dimensions.width10),
          Expanded(
            child: BigText(
              text: widget.name.toString(),
              size: Dimensions.font16,
              color: AppColors.mainBlackColor,
              overFlow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}
