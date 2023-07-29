import 'package:shared_preferences/shared_preferences.dart';

import '/controllers/cart_controller.dart';
import '/controllers/popular_product_controller.dart';
import '/controllers/recommended_product_controller.dart';
import '../../config/constants/app_constants.dart';
import '/data/api/api_client.dart';
import '/data/repository/cart_repo.dart';
import '/data/repository/popular_product_repo.dart';
import '/data/repository/recommended_product_repo.dart';
import 'package:get/get.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(share: Get.find()));

  //controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
