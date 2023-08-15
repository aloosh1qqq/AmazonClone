// ignore_for_file: constant_identifier_names

class AppConstants {
  static const String APP_NAME = "Ecommerce-App";
  static const int APP_VERSION = 1;

// http://10.0.2.2:3000

// https://secandfifthpro.herokuapp.com

  static const String BASE_URL = "http://10.0.2.2:3000";
  static const String POPULAR_PRODUCT_URI = "/api/products";
  static const String RECOMMENDED_PRODUCT_URI = "/api/products";
  static const String CATEGORY_PRODUCT_URI =
      "/api/products/category/?category=";
  static const String USERID_PRODUCT_URI = "/api/products/userId?userId=";
  static const String Add_Product_URI = "/admin/add-product";
  static const String Delete_Product_URI = "/admin/delete-product";
  static const String Update_Product_URI = "/admin/updateProduct";
  static const String rate_Product_URI = "/api/rate-product";

  static const String REGISTRATION_URI = "/api/signup";
  static const String LOGIN_URI = "/api/signin";
  static const String USER_INFO_URI = "/api/user/me";

  static const String TOKEN = "DBtoken";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
}
