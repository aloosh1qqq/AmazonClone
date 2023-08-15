import 'dart:convert';

import 'package:food_delivery/models/response_model.dart';
import 'package:food_delivery/models/user_model.dart';
import 'package:get/get.dart';

import '../data/api/repository/user_repo.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});
  bool _isLoading = false;
  UserModle _userModel = UserModle();
  bool get isLoading => _isLoading;
  UserModle get userModel => _userModel;

  UserModle _user = UserModle();

  UserModle get user => _user;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModle.fromJson(response.body['user'][0]);
      _isLoading = true;
      responseModel = ResponseModel(true, "successfully");
      update();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    update();
    return responseModel;
  }

  Future<void> getUserInfoForProduct(String userid) async {
    Response response = await userRepo.getUserInfoForProduct(userid);
    if (response.statusCode == 200) {
      _user = UserModle.fromJson(response.body['user'][0]);
      _isLoading = true;
      update();
    }
  }
}
