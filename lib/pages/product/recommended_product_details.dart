import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';

import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/user_widget.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_controller.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetails(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    UserController u1 = Get.find<UserController>();
    u1.getUserInfo();
    double avgRating = 0;

    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }
    Future openDialog() => showDialog(
        context: context,
        useSafeArea: true,
        builder: (context) => AlertDialog(
              title: const Text("Rate Product"),
              content: SizedBox(
                width: Dimensions.width10,
                height: Dimensions.height10,
                child: Center(
                  child: RatingBar.builder(
                    itemSize: 30,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_rounded,
                      color: Colors.amberAccent,
                    ),
                    onRatingUpdate: (double value) async {
                      bool _userLoggedIn =
                          Get.find<AuthController>().userLoggedIn();
                      if (_userLoggedIn) {
                        u1.getUserInfo();
                        await Get.find<ProductController>().rateProduct(
                            value, u1.userModel.id2!, product.id2!);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'))
              ],
            ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,

            toolbarHeight: 70,
            //leading: Container(),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      if (page == "cartpage") {
                        Get.toNamed(RouteHelper.getCartPage());
                      } else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.clear)),
                //AppIcon(icon: Icons.shopping_cart_outlined)
                GetBuilder<PopularProductController>(
                  builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1)
                          Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 3,
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ))
                              : Container()
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(350),
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: UserWidget(
                        name: product.username.toString(),
                        image: product.userimage.toString(),
                      ),
                    ),
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20),
                            topRight: Radius.circular(Dimensions.radius20))),
                  ),
                ],
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.images[0],
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BigText(
                        text: "Name : ",
                        size: Dimensions.font16,
                        color: AppColors.textColor,
                      ),
                      BigText(text: product.name!, size: Dimensions.font20),
                    ],
                  ),
                  Row(
                    children: [
                      BigText(
                        text: "Rating : ",
                        size: Dimensions.font16,
                        color: AppColors.textColor,
                      ),
                      RatingBarIndicator(
                        itemSize: 30,
                        rating: avgRating,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star_rounded,
                          color: Colors.amberAccent,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          openDialog();
                        },
                        child: Icon(
                          Icons.rate_review_outlined,
                          color: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BigText(
                        text: "Category : ",
                        size: Dimensions.font16,
                        color: AppColors.textColor,
                      ),
                      BigText(
                        text: product.category!,
                        size: Dimensions.font16,
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  BigText(
                    text: "Discription : ",
                    size: Dimensions.font16,
                    color: AppColors.mainBlackColor,
                  ),
                  ExpandableTextWidget(
                    text: product.description!,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  product.category == "laptop" || product.category == "computer"
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconAndTextWidget(
                                    icon: SizedBox(
                                      child:
                                          Image.asset('assets/icons/cpu.png'),
                                      height: Dimensions.iconSize24,
                                    ),
                                    text: product.cpu!,
                                    iconColor: AppColors.iconColor1),
                                IconAndTextWidget(
                                    icon: SizedBox(
                                      child: Image.asset(
                                          'assets/icons/gpu_icon.png'),
                                      height: Dimensions.iconSize24,
                                    ),
                                    text: product.gpu!,
                                    iconColor: AppColors.iconColor2),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.width10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconAndTextWidget(
                                    icon: Container(
                                      child: Image.asset(
                                          'assets/icons/ram-memory.png'),
                                      height: Dimensions.iconSize24,
                                    ),
                                    text: product.ram!,
                                    iconColor: AppColors.iconColor1),
                                IconAndTextWidget(
                                    icon: Container(
                                      child:
                                          Image.asset('assets/icons/hdd.png'),
                                      height: Dimensions.iconSize24,
                                    ),
                                    text: product.storage!,
                                    iconColor: AppColors.iconColor2),
                              ],
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20 * 2.5,
                    right: Dimensions.width20 * 2.5,
                    top: Dimensions.height10,
                    bottom: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(false, product.quantity);
                      },
                      child: AppIcon(
                          iconSize: Dimensions.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          icon: Icons.remove),
                    ),
                    BigText(
                      text: "\$ ${product.price!} X ${controller.inCartItems} ",
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font26,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setQuantity(true, product.quantity);
                      },
                      child: AppIcon(
                          iconSize: Dimensions.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor: AppColors.mainColor,
                          icon: Icons.add),
                    )
                  ],
                ),
              ),
              Container(
                height: Dimensions.bottomHeightBar,
                padding: EdgeInsets.only(
                    top: Dimensions.height30,
                    bottom: Dimensions.height30,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20 * 2),
                        topRight: Radius.circular(Dimensions.radius20 * 2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white),
                        child: Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        )),
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        child: BigText(
                          text: "\$ ${product.price!} | Add to cart",
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
