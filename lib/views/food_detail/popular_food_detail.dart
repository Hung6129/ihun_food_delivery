import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ihun_food_delivery/controllers/cart_controller.dart';
import 'package:ihun_food_delivery/controllers/popular_product_controller.dart';

import 'package:ihun_food_delivery/views/food_detail/widgets/food_detail_widgets.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({
    super.key,
    required this.pageId,
    required this.page,
  });
  final int pageId;
  final String page;
  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            sliverAppBarFoodDetail(product),
            sliverToBoxAdapterFoodDetail(product),
          ],
        ),
        bottomSheet: bottomSheetFoodDetailToCart(context, product));
  }
}
