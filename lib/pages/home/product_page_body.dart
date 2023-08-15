// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/models/user_model.dart';

import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:food_delivery/widgets/user_widget.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  double _currentIndex = 0.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Container doesn't have a default height
    //Child container always takes height of parent so 320 only working not 220 so we need to take stack widget to get it into the shape provided
    //page value in the scroller will increase or decrease with decimal point slowly and index value case is completely opposite
    return Column(
      children: [
        //Slider Sections
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? SizedBox(
                  height: Dimensions.pageView,
                  child: CarouselSlider.builder(
                      options: CarouselOptions(
                          height: Dimensions.pageViewContainer,
                          enlargeCenterPage: true,
                          disableCenter: true,
                          viewportFraction: 0.85,
                          autoPlayInterval: Duration(seconds: 5),
                          autoPlay: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            _currentIndex = index.toDouble();
                            setState(() {});
                          }),
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position, pageid) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }))
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),

        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currentIndex,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              shape: const Border(),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
            ),
          );
        }),
        SizedBox(
          height: Dimensions.height30,
        ),

        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: "Product pairing",
                ),
              ),
            ],
          ),
        ),
        //Parent container should have a certain height
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isloaded
              ? ListView.builder(
                  reverse: true,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProductList.length,
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
                                          .recommendedProductList[index]
                                          .images[0]))),
                            ),
                            //Expanded widget wil force the container to take all the space in the place available
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getRecommendedFood(
                                      index, "home"));
                                },
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                                text: recommendedProduct
                                                    .recommendedProductList[
                                                        index]
                                                    .name!),
                                            UserWidget(
                                              name: recommendedProduct
                                                  .recommendedProductList[index]
                                                  .username,
                                              image: recommendedProduct
                                                  .recommendedProductList[index]
                                                  .userimage!,
                                            )
                                          ],
                                        ),
                                        SmallText(
                                          text: recommendedProduct
                                                  .recommendedProductList[index]
                                                  .price
                                                  .toString() +
                                              " S.P",
                                          size: Dimensions.font16,
                                        ),
                                        BigText(
                                          text: recommendedProduct
                                              .recommendedProductList[index]
                                              .description!,
                                          size: Dimensions.font16,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    double avgRating = 0;

    double totalRating = 0;
    for (int i = 0; i < popularProduct.rating!.length; i++) {
      totalRating += popularProduct.rating![i].rating;
    }
    if (totalRating != 0) {
      avgRating = totalRating / popularProduct.rating!.length;
    }
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getPopularFood(index, "home"));
          },
          child: Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Color(0xFF69c5df),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(popularProduct.images[0]))),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.pageViewTextContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)),
                  BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                  BoxShadow(color: Colors.white, offset: Offset(5, 0))
                ]),
            child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.height15,
                    right: Dimensions.height15),
                child: AppColumn(
                    text: popularProduct.name!,
                    cpu: popularProduct.cpu!,
                    gpu: popularProduct.gpu!,
                    userImage: popularProduct.userimage,
                    userName: popularProduct.username,
                    catigory: popularProduct.category!,
                    discription: popularProduct.description,
                    avgRating: avgRating)),
          ),
        ),
      ],
    );
  }
}
