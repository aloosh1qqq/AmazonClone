import 'package:flutter/material.dart';

import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/product_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/products_model.dart';

import 'package:food_delivery/pages/product/edit_product.dart';

import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/own_prod_box.dart';
import 'package:food_delivery/widgets/radis_butten.dart';

import 'package:get/get.dart';

class OwnProduct extends StatefulWidget {
  const OwnProduct({Key? key}) : super(key: key);

  @override
  State<OwnProduct> createState() => _OwnProductState();
}

class _OwnProductState extends State<OwnProduct> {
  Future<void> _loadResource() async {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      await Get.find<UserController>().getUserInfo();
    }

    await Get.find<PopularProductController>().getPopularProductList();
  }

  late bool _userLoggedIn;
  late int selectedCollection = 0;
  int productCount = 0;

  @override
  void initState() {
    // TODO: implement initState

    _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    Get.find<UserController>().getUserInfo();
    super.initState();
    _loadResource();
  }

  late ProductModel selectedProd;

  void add() {
    Get.toNamed(RouteHelper.getAddProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _userLoggedIn
          ? RefreshIndicator(
              onRefresh: _loadResource,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child:
                    GetBuilder<PopularProductController>(builder: (products) {
                  products.getProductByUserId(
                      Get.find<UserController>().userModel.id2.toString());
                  return Stack(
                    children: [
                      products.productUserList.length != 0
                          ? GridView.builder(
                              itemCount: products.productUserList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                productCount = products.productUserList.length;
                                final productData =
                                    products.productUserList[index];
                                selectedProd = products
                                    .productUserList[selectedCollection];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: OwnProd(
                                    data: productData,
                                    selectedColor: Colors.white,
                                    isSelected: selectedCollection == index
                                        ? true
                                        : false,
                                    onTap: () {
                                      selectedCollection = index;
                                      selectedProd = products
                                          .productUserList[selectedCollection];
                                    },
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: BigText(text: "You dont have product yet"),
                            ),
                      Positioned(
                        bottom: Dimensions.height20,
                        right: -Dimensions.width20,
                        child: SizedBox(
                          height: 500,
                          width: 500,
                          child: RadiosButten(
                            onTapADD: add,
                            onTapDell: () {
                              if (productCount > 0) {
                                Get.find<ProductController>()
                                    .deleteProd(selectedProd);
                                _loadResource();
                              } else {
                                showCustomSnackBar("Their is no product");
                              }
                            },
                            onTapEdit: () {
                              if (productCount > 0) {
                                openDialog();
                              } else {
                                showCustomSnackBar("Their is no product");
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
            )
          : Center(child: BigText(text: "Plase login first")),
    );
  }

  Future openDialog() => showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => AlertDialog(
            title: const Text("Edit Product"),
            content: SizedBox(
              width: Dimensions.width15 * 30,
              child: EditProduct(
                  prodId: selectedProd.id2!,
                  name: selectedProd.name!,
                  category: selectedProd.category!,
                  deisc: selectedProd.description!,
                  price: selectedProd.price.toString(),
                  quantity: selectedProd.quantity.toString(),
                  prodImage: selectedProd.images),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'))
            ],
          ));
}
