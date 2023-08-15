import 'package:flutter/material.dart';

import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';

import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/user_widget.dart';
import 'package:get/get.dart';

class CategoryView extends StatefulWidget {
  String categoryName;
  CategoryView({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryView();
}

class _CategoryView extends State<CategoryView> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().clear();
    Get.find<PopularProductController>()
        .getProductListByCategory(widget.categoryName);
    return GetBuilder<PopularProductController>(builder: (recommendedProduct) {
      return recommendedProduct.isLoadedCategory
          ? recommendedProduct.popularProductListCategory.isNotEmpty
              ? ListView.builder(
                  reverse: true,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      recommendedProduct.popularProductListCategory.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                            RouteHelper.getRecommendedFood(index, "home"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height10),
                        child: Row(
                          children: [
                            Container(
                              width: Dimensions.listViewImgSize,
                              height: Dimensions.listViewImgSize,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(recommendedProduct
                                          .popularProductListCategory[index]
                                          .images[0]))),
                            ),
                            //Expanded widget wil force the container to take all the space in the place available
                            Expanded(
                              child: Container(
                                height: Dimensions.listViewTextContSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            Dimensions.radius20),
                                        bottomRight: Radius.circular(
                                            Dimensions.radius20)),
                                    color: Colors.white),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                              text: recommendedProduct
                                                  .popularProductListCategory[
                                                      index]
                                                  .name!),
                                          UserWidget(
                                            name: recommendedProduct
                                                .popularProductListCategory[
                                                    index]
                                                .username,
                                            image: recommendedProduct
                                                        .popularProductListCategory[
                                                            index]
                                                        .userimage ==
                                                    'image'
                                                ? "https://i.pinimg.com/originals/10/b2/f6/10b2f6d95195994fca386842dae53bb2.png"
                                                : recommendedProduct
                                                    .popularProductListCategory[
                                                        index]
                                                    .userimage,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextWidget(
                                              icon: Container(
                                                child: Image.asset(
                                                    'assets/icons/cpu.png'),
                                                height: Dimensions.iconSize24,
                                              ),
                                              text: "Normal",
                                              iconColor: AppColors.iconColor1),
                                          IconAndTextWidget(
                                              icon: Container(
                                                child: Image.asset(
                                                    'assets/icons/gpu_icon.png'),
                                                height: Dimensions.iconSize24,
                                              ),
                                              text: "32min",
                                              iconColor: AppColors.iconColor2),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : Center(
                  child: BigText(text: "There is no products yet!"),
                )
          : Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
    });
  }
}
