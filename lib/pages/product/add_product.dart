import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/product_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/utils/pick_image.dart';
import 'package:food_delivery/widgets/app_test_field.dart';
import 'package:food_delivery/widgets/custom_button.dart';
import 'package:food_delivery/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController cpuController = TextEditingController();
  final TextEditingController gpuController = TextEditingController();
  final TextEditingController ramController = TextEditingController();
  final TextEditingController storageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    cpuController.dispose();
    gpuController.dispose();
    ramController.dispose();
    storageController.dispose();
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = [];
      images = res;
    });
  }

  String category = 'laptop';
  List<File> images = [];
  GlobalKey<FormState> _addProductFormKey = GlobalKey<FormState>();
  List<String> productCategories = [
    'laptop',
    'Desktop',
    'electronic',
    'smart watch',
    'printer'
  ];

  @override
  Widget build(BuildContext context) {
    UserController u1 = Get.find<UserController>();
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      u1.getUserInfo();
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _addProductFormKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                    onTap: selectImages,
                    child: images.isNotEmpty
                        ? CarouselSlider(
                            items: images.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.cover,
                                    height: Dimensions.pageViewContainer,
                                  ),
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: Dimensions.pageViewContainer,
                            ),
                          )
                        : DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: Dimensions.pageViewContainer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Select Product Images',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: productNameController,
                    hintText: 'Product Name',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: descriptionController,
                    hintText: 'Description',
                    maxLines: 7,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: priceController,
                    hintText: 'Price',
                  ),
                  Visibility(
                      visible: category == 'laptop' ? true : false,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: cpuController,
                            hintText: 'Cpu',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: gpuController,
                            hintText: 'Gpu',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: ramController,
                            hintText: 'RAM',
                          ),
                          const SizedBox(height: 10),
                          CustomTextField(
                            controller: storageController,
                            hintText: 'Storage',
                          ),
                        ],
                      )),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: quantityController,
                    hintText: 'Quantity',
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: productCategories.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          category = newVal!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<ProductController>(builder: (productController) {
                    return CustomButton(
                      text: productController.isloading ? 'Processing' : 'Sell',
                      icon: productController.isloading
                          ? CircularProgressIndicator(
                              color: AppColors.mainColor,
                            )
                          : Icon(
                              Icons.upload_file,
                              color: AppColors.mainColor,
                            ),
                      onTap: () {
                        try {
                          if (productNameController.text.isEmpty) {
                            showCustomSnackBar("Type in your name",
                                title: "Name");
                          } else if (descriptionController.text.isEmpty) {
                            showCustomSnackBar("Type in your discription",
                                title: "Description");
                          } else if (priceController.text.isEmpty) {
                            showCustomSnackBar("Type in your price",
                                title: "Price");
                          } else if (quantityController.text.isEmpty) {
                            showCustomSnackBar("Type in your quantity",
                                title: "Quantity");
                          } else {
                            u1.getUserInfo();
                            print(u1.userModel.id2);
                            productController.addProduct(
                                productNameController.text,
                                descriptionController.text,
                                int.parse(quantityController.text),
                                images,
                                category,
                                int.parse(priceController.text),
                                u1.userModel.id2.toString());
                            Get.toNamed(RouteHelper.initial);
                          }
                        } catch (e) {
                          showCustomSnackBar(e.toString(), title: "Error");
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
