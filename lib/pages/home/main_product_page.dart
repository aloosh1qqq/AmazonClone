import 'package:flutter/material.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/pages/home/category_view.dart';
import 'package:food_delivery/pages/home/product_page_body.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/category_box.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

//Aikhan a app ar main page ta thakbay
//slider of the top r nicher list of food items
class MainProductPage extends StatefulWidget {
  const MainProductPage({Key? key}) : super(key: key);

  @override
  _MainProductPageState createState() => _MainProductPageState();
}

class _MainProductPageState extends State<MainProductPage> {
  Future<void> _loadResource() async {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      await Get.find<UserController>().getUserInfo();
    }

    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  late int selectedCollection;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    selectedCollection = 0;
  }

  @override
  Widget build(BuildContext context) {
    //we will take column and in that we will give side wise contents as row
    //column has a default property of center things in top corner of the screen
    //row has default property of center in the y axis center
    // to make above both as header we'll put all container in a column to give the top corner default property
    //We've wrapped the container with scaffold to prevent the black screen
    print("current height " + MediaQuery.of(context).size.height.toString());

    return RefreshIndicator(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: Dimensions.height15),
                  padding: EdgeInsets.only(
                      left: Dimensions.width10, right: Dimensions.width10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: Dimensions.height20,
                            left: Dimensions.width10,
                            right: Dimensions.width10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/image/logo.png",
                              color: AppColors.textColor,
                              height: Dimensions.height30,
                            ),
                            SizedBox(
                              width: Dimensions.width10,
                            ),
                            Text(
                              "E-commerce App",
                              style: TextStyle(
                                  fontSize: Dimensions.font20,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          width: Dimensions.width30,
                          height: Dimensions.height30,
                          child: Icon(Icons.search,
                              color: AppColors.mainColor,
                              size: Dimensions.iconSize24),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.mainColor),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15 / 2),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(
                              categories.length,
                              (index) => Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: CategoryBox(
                                    selectedColor: Colors.white,
                                    data: categories[index],
                                    isSelected: selectedCollection == index
                                        ? true
                                        : false,
                                    onTap: () {
                                      selectedCollection = index;

                                      setState(() {});
                                    },
                                  )))),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    selectedCollection == 0
                        ? const FoodPageBody()
                        : CategoryView(
                            categoryName: categories
                                .elementAt(selectedCollection)['name'])
                  ],
                ),
              ),
            ),
          ],
        ),
        onRefresh: _loadResource);
  }
}

List categories = [
  {"name": "All", "icon": "assets/icons/category/all.svg"},
  {"name": "laptop", "icon": "assets/icons/category/laptop.svg"},
  {"name": "Desktop", "icon": "assets/icons/category/coding.svg"},
  {"name": "electronic", "icon": "assets/icons/category/devices.svg"},
  {"name": "smart watch", "icon": "assets/icons/category/watch.svg"},
  {"name": "printer", "icon": "assets/icons/category/printer.svg"},
  {"name": "Program", "icon": "assets/icons/category/window.svg"},
];
