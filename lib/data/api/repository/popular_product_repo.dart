import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }

  Future<Response> getProductListByCategory(String categoryName) async {
    return await apiClient
        .getData(AppConstants.CATEGORY_PRODUCT_URI + categoryName);
  }

  Future<Response> getProductListByUserId(String userId) async {
    return await apiClient.getData(AppConstants.USERID_PRODUCT_URI + userId);
  }
}
