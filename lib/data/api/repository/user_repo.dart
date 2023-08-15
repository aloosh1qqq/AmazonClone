import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/app_constants.dart';

class UserRepo {
  final ApiClient apiClient;

  UserRepo({required this.apiClient});
  Future<Response> getUserInfoForProduct(String userId) async {
    return await apiClient.getData(AppConstants.USER_INFO_URI,
        headers: {"id": userId.toString()});
  }

  Future<Response> getUserInfo() async {
    return await apiClient.getData(
      AppConstants.USER_INFO_URI,
    );
  }
}
