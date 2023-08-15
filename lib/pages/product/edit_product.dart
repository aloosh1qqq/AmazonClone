import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/product_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/utils/pick_image.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/app_test_field.dart';
import 'package:food_delivery/widgets/custom_button.dart';
import 'package:food_delivery/widgets/custom_textfield.dart';
import 'package:get/get.dart';

class EditProduct extends StatefulWidget {
  static const String routeName = '/add-product';
  EditProduct(
      {Key? key,
      required this.name,
      required this.deisc,
      required this.price,
      required this.quantity,
      required this.category,
      required this.prodId,
      required this.prodImage})
      : super(key: key);
  String name;
  String deisc;
  String price;
  String quantity;
  String category = '';
  List<String> prodImage;
  String prodId;

  @override
  State<EditProduct> createState() => _EditProduct();
}

class _EditProduct extends State<EditProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController cpuController = TextEditingController();
  final TextEditingController gpuController = TextEditingController();
  final TextEditingController ramController = TextEditingController();
  final TextEditingController storageController = TextEditingController();
  final ScrollController listController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void deletImage(int index) async {
    setState(() {
      prodImage.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productNameController.text = widget.name;
    descriptionController.text = widget.deisc;
    priceController.text = widget.price;
    quantityController.text = widget.quantity;
    category = widget.category;
    prodImage.addAll(widget.prodImage);
  }

  String category = 'laptop';
  List<String> prodImage = [];
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  List<String> productCategories = [
    'laptop',
    'Desktop',
    'electronic',
    'smart watch',
    'printer'
  ];
  UserController u1 = Get.find<UserController>();
  bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
  @override
  Widget build(BuildContext context) {
    if (userLoggedIn) {
      u1.getUserInfo();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _addProductFormKey,
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
                                    fit: BoxFit.scaleDown,
                                    height: Dimensions.height45 * 3,
                                  ),
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                              height: Dimensions.height45 * 3,
                            ),
                          )
                        : DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(20),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: Dimensions.height45 * 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_copy,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Add Product Images',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                const SizedBox(
                  height: 20,
                ),
                prodImage.isEmpty
                    ? Container()
                    : SizedBox(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: listController,
                            itemCount: prodImage.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(prodImage[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: Dimensions.height10 * 7,
                                      width: Dimensions.height10 * 7,
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () => deletImage(index),
                                        child: AppIcon(
                                          icon: Icons.delete_forever,
                                          size: Dimensions.height20,
                                          backgroundColor: Colors.redAccent,
                                          iconSize: Dimensions.iconSize16,
                                        ),
                                      ))
                                ],
                              );
                            }),
                      ),
                const SizedBox(height: 20),
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
                CustomButton(
                  icon: Icon(Icons.abc_outlined),
                  text: 'Save',
                  onTap: () async {
                    try {
                      if (productNameController.text.isEmpty) {
                        showCustomSnackBar("Type in your name", title: "Name");
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
                        if (images.isNotEmpty) {
                          final cloudinary =
                              CloudinaryPublic('zeusali', 'tz3wrzys');
                          for (int i = 0; i < images.length; i++) {
                            CloudinaryResponse res =
                                await cloudinary.uploadFile(
                              CloudinaryFile.fromFile(images[i].path,
                                  folder: productNameController.text),
                            );
                            prodImage.add(res.secureUrl);
                          }
                        }
                        await Get.find<ProductController>().updateProduct(
                            productNameController.text,
                            descriptionController.text,
                            int.parse(priceController.text),
                            prodImage,
                            category,
                            int.parse(priceController.text),
                            widget.prodId);

                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      showCustomSnackBar(e.toString());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
