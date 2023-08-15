import 'dart:io';

import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;

  ProductRepo({required this.apiClient});

  Future<Response> addProductService(
      String name,
      String description,
      int quantity,
      List<File> images,
      String category,
      int price,
      String userId) async {
    final cloudinary = CloudinaryPublic('zeusali', 'tz3wrzys');
    List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(images[i].path, folder: name),
      );
      imageUrls.add(res.secureUrl);
    }

    ProductModel product = ProductModel(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
        userId: userId,
        ram: "82",
        cpu: "cpu",
        gpu: "gpu",
        id: 564,
        storage: "asd");
    return await apiClient.post(
      AppConstants.Add_Product_URI,
      product.toJson(),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': "userProvider.user.token",
      },
    );
  }

  Future<Response> deleteProduct(ProductModel prod) async {
    return await apiClient
        .postData(AppConstants.Delete_Product_URI, {'id': prod.id2});
  }

  Future<Response> updateProduct(String name, String description, int quantity,
      List<String> images, String category, int price, String id) async {
    return await apiClient.postData(AppConstants.Update_Product_URI, {
      "_id": id,
      "name": name,
      "description": description,
      "quantity": quantity,
      "price": price,
      "category": category,
      "images": images,
    });
  }

  Future<Response> rateproduct(double rating, String userId, String id) async {
    return await apiClient.postData(AppConstants.rate_Product_URI, {
      "id": id,
      "rating": rating,
      "userid": userId,
    });
  }
}
