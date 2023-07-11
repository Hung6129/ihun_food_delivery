import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controllers/cart_controller.dart';
import 'controllers/popular_product_controller.dart';
import 'controllers/recommended_product_controller.dart';
import 'config/routes/route_helper.dart';
import 'helper/dependencies.dart' as depen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await depen.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (controller) {
        return GetBuilder<RecommendedProductController>(
          builder: (controller) {
            return ScreenUtilInit(
              builder: (context, child) => GetMaterialApp(
                theme: ThemeData(useMaterial3: true),
                title: 'iHun Food Delivery App',
                debugShowCheckedModeBanner: false,
                initialRoute: RoutesHelper.getSplash(),
                getPages: RoutesHelper.routes,
              ),
            );
          },
        );
      },
    );
  }
}
