import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihun_food_delivery/config/palettes.dart';
import 'package:ihun_food_delivery/config/text_styles.dart';
import 'package:ihun_food_delivery/controllers/cart_controller.dart';
import 'package:ihun_food_delivery/controllers/popular_product_controller.dart';
import 'package:ihun_food_delivery/core/app_constants.dart';

import 'package:ihun_food_delivery/config/dimension.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ihun_food_delivery/config/routes/route_helper.dart';
import 'package:ihun_food_delivery/pages/food_detail/widgets/food_detail_widgets.dart';

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
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(Dimensions.height30),
                ),
              ),
              expandedHeight: Dimensions.backGroundDetailImage,
              stretch: true,
              automaticallyImplyLeading: false,
              leading: GestureDetector(
                child: const Icon(Icons.arrow_back_ios_new),
                onTap: () {
                  if (page == 'cart-page') {
                    Get.toNamed(RoutesHelper.getCart());
                  } else {
                    Get.toNamed(RoutesHelper.getInitial());
                  }
                },
              ),
              actions: [
                GetBuilder<PopularProductController>(
                  builder: ((controller) {
                    return (Get.find<PopularProductController>().totalItems >= 1
                        ? badges.Badge(
                            badgeStyle: const BadgeStyle(badgeColor: Palettes.p1),
                            badgeAnimation: const badges.BadgeAnimation.slide(),
                            badgeContent: controller.totalItems >= 1
                                ? Text(
                                    controller.totalItems.toString(),
                                    style: TextStyles.defaultStyle.whiteText,
                                  )
                                : const SizedBox(),
                            child: IconButton(
                              onPressed: () {
                                Get.toNamed(RoutesHelper.getCart());
                              },
                              icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              Get.toNamed(RoutesHelper.getCart());
                            },
                            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                          ));
                  }),
                ),
                SizedBox(width: Dimensions.height20)
              ],
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.zoomBackground],
                background: CachedNetworkImage(
                  imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URI + product.img!,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(Dimensions.height10),
                  child: Text(
                    product.name!,
                    style: TextStyle(fontSize: Dimensions.font26),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Dimensions.height10),
                  child: Text(product.description!),
                ),
              ],
            )),
          ],
        ),
        bottomSheet: bottomSheetFoodToCart(context, product));
  }
}
