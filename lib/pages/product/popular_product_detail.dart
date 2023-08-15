import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/product_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/pages/home/main_product_page.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/widgets/user_widget.dart';
import 'package:get/get.dart';

import '../../../routes/route_helper.dart';
import '../../../utils/colors.dart';
import '../../../widgets/big_text.dart';
import '../cart/cart_page.dart';

class PopularFoodDetail extends StatefulWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  State<PopularFoodDetail> createState() => _PopularFoodDetailState();
}

class _PopularFoodDetailState extends State<PopularFoodDetail> {
  PageController pageController = PageController();

  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        Get.find<PopularProductController>().popularProductList[widget.pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    UserController u1 = Get.find<UserController>();
    u1.getUserInfo();
    double avgRating = 0;
    double myRating = 0;
    double totalRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
      u1.getUserInfo();
      if (product.rating![i].userId == u1.userModel.id2) {
        myRating = product.rating![i].rating;
      }
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
      body: Stack(
        children: [
          //Background image
          Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                color: Colors.transparent,
                child: PageView(
                  controller: pageController,
                  children: [
                    for (int i = 0; i < product.images.length; i++)
                      Image.network(
                        product.images[i],
                        fit: BoxFit.fitHeight,
                        width: double.maxFinite,
                        height: Dimensions.popularFoodImgSize,
                      ),
                  ],
                ),
              )),
          //Icon widgets
          Positioned(
              top: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (widget.page == "cartpage") {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child:
                          const AppIcon(icon: Icons.arrow_back_ios_outlined)),
                  GetBuilder<PopularProductController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          if (controller.totalItems >= 1) {
                            Get.toNamed(RouteHelper.getCartPage());
                          }
                        },
                        child: Stack(
                          children: [
                            const AppIcon(icon: Icons.shopping_cart_outlined),
                            controller.totalItems >= 1
                                // ignore: prefer_const_constructors
                                ? Positioned(
                                    right: 0,
                                    top: 0,
                                    // ignore: prefer_const_constructors
                                    child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: AppColors.textColor,
                                      backgroundColor: AppColors.textColor,
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
              )),

          //Introduction of food

          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize - 100,
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserWidget(
                      name: product.username,
                      image: product.userimage,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BigText(
                          text: "Rating : ",
                          size: Dimensions.font16,
                          color: AppColors.textColor,
                        ),
                        RatingBarIndicator(
                          itemSize: 30,
                          direction: Axis.horizontal,
                          rating: avgRating,
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
                    product.category == "laptop" ||
                            product.category == "computer"
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    BigText(text: "Discription :"),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ExpandableTextWidget(text: product.description!),
                            SizedBox(
                              height: Dimensions.height30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          //Expandable text widget

          Positioned(
            top: Dimensions.popularFoodImgSize - 80,
            right: 0,
            left: 0,
            child: DotsIndicator(
              dotsCount: product.images.length,
              position: pageController.hasClients ? pageController.page! : 0,
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
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
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(
                                false, product.quantity!);
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          )),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true, product.quantity!);
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          ))
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                    Get.snackbar("Added", popularProduct.inCartItems.toString(),
                        titleText: BigText(
                          text: "Added",
                          color: Colors.white,
                        ),
                        messageText: Text(
                          popularProduct.inCartItems.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        snackPosition: SnackPosition.TOP,
                        colorText: Colors.white,
                        backgroundColor: AppColors.mainColor);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width30),
                    child: BigText(
                      text: "\$ ${product.price!} | Add to cart",
                      color: Colors.white,
                      size: Dimensions.font16,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
