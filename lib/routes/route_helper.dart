import 'package:food_delivery/pages/auth/sign_in_page.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';

import 'package:food_delivery/pages/home/category_view.dart';
import 'package:food_delivery/pages/product/add_product.dart';
import 'package:food_delivery/pages/product/popular_product_detail.dart';
import 'package:food_delivery/pages/product/recommended_product_details.dart';
import 'package:food_delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/home/home_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addProduct = "/add-product";
  static const String category = "/category";
  static const String carts = "/cartHistory";

  static String getSplashPage() => splashPage;
  static String getCarts() => carts;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => cartPage;
  static String getSignInPage() => signIn;
  static String getAddProduct() => addProduct;
  static String getCategory(String categoryName) =>
      '$category?category=$categoryName';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => const SplashScreen()),
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(
        name: signIn,
        page: () {
          return SignInPage();
        },
        transition: Transition.fade),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetails(
              pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: addProduct,
        page: () {
          return const AddProductScreen();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: category,
        page: () {
          var categoryName = Get.parameters['category'];
          return CategoryView(
            categoryName: categoryName!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: carts,
        page: () {
          return const CartHistory();
        },
        transition: Transition.fadeIn),
  ];
}
