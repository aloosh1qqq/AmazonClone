import 'dart:io';

import 'package:food_delivery/data/api/repository/product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;
  bool _isLoading = false;
  bool get isloading => _isLoading;

  ProductController({required this.productRepo});
  Future<void> addProduct(String name, String description, int quantity,
      List<File> images, String category, int price, String userId) async {
    _isLoading = true;
    await productRepo.addProductService(
        name, description, quantity, images, category, price, userId);
    _isLoading = false;
  }

  Future<void> deleteProd(ProductModel productModel) async {
    _isLoading = true;
    await productRepo.deleteProduct(productModel);
    _isLoading = false;
    update();
  }

  Future<void> rateProduct(double rating, String userId, String id) async {
    await productRepo.rateproduct(rating, userId, id);
  }

  Future<void> updateProduct(String name, String description, int quantity,
      List<String> images, String category, int price, String id) async {
    _isLoading = true;
    await productRepo.updateProduct(
        name, description, quantity, images, category, price, id);
    _isLoading = false;
  }
}
