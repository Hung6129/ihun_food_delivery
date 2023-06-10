import 'package:ihun_food_delivery/main_menu_page.dart';
import '/pages/splash/splash_page.dart';
import '/pages/cart/cart_page.dart';
import '/pages/food/popular_food_detail.dart';
import '/pages/food/recommended_food_detail.dart';
import 'package:get/get.dart';

class RoutesHelper {
  static const String initial = "/";
  static const String splash = "/splash";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getInitial() => initial;
  static String getSplash() => splash;
  static String getPopularFood(int pageId, String page) =>
      "$popularFood?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId, String page) =>
      "$recommendedFood?pageId=$pageId&page=$page";
  static String getCart() => cartPage;

  static List<GetPage> routes = [
    GetPage(
        name: splash,
        page: () => const SplashScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: initial,
        page: () => const MainMenuPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters["pageId"];
          var page = Get.parameters["page"];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters["pageId"];
          var page = Get.parameters["page"];
          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          // var pageId = Get.parameters["pageId"];
          return const CartPage();
        },
        transition: Transition.native),
  ];
}
