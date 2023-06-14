import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihun_food_delivery/controllers/cart_controller.dart';
import 'package:ihun_food_delivery/controllers/popular_product_controller.dart';
import 'package:ihun_food_delivery/custom/app_constants.dart';
import 'package:ihun_food_delivery/custom/app_icon.dart';
import 'package:ihun_food_delivery/custom/big_text.dart';
import 'package:ihun_food_delivery/custom/dimension.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ihun_food_delivery/routes/route_helper.dart';
import 'package:ihun_food_delivery/theme/palette.dart';

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
            actions: [
              GetBuilder<PopularProductController>(
                builder: ((controller) {
                  return (Get.find<PopularProductController>().totalItems >= 1
                      ? badges.Badge(
                          badgeStyle: const BadgeStyle(badgeColor: Palette.mainColor),
                          badgeAnimation: const badges.BadgeAnimation.slide(),
                          badgeContent: controller.totalItems >= 1
                              ? BigText(
                                  text: Get.find<PopularProductController>().totalItems.toString(),
                                  size: Dimensions.font14,
                                )
                              : const SizedBox(),
                          child: GestureDetector(
                              onTap: () {
                                Get.toNamed(RoutesHelper.getCart());
                              },
                              child: const AppIcon(icon: Icons.shopping_cart_outlined)),
                        )
                      : GestureDetector(
                          onTap: () {
                            Get.toNamed(RoutesHelper.cartPage);
                          },
                          child: const AppIcon(icon: Icons.shopping_cart_outlined)));
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
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
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
      bottomSheet: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                Dimensions.height30,
              ),
              topRight: Radius.circular(
                Dimensions.height30,
              ),
            ),
          ),
          color: Palette.mainColor,
        ),
        width: double.maxFinite,
        height: Dimensions.bottomSheet,
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return GetBuilder<PopularProductController>(
                            builder: (controller) => SizedBox(
                                  height: Dimensions.bottomSheetPopUp,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              child: Text(
                                                '-',
                                                style: TextStyle(fontSize: Dimensions.font26),
                                              ),
                                              onPressed: () => controller.setQuantity(false),
                                            ),
                                            SizedBox(
                                              width: Dimensions.height15,
                                            ),
                                            Text(
                                              controller.inCartItems.toString(),
                                              style: TextStyle(fontSize: Dimensions.font26),
                                            ),
                                            SizedBox(
                                              width: Dimensions.height15,
                                            ),
                                            ElevatedButton(
                                              child: Text(
                                                '+',
                                                style: TextStyle(fontSize: Dimensions.font26),
                                              ),
                                              onPressed: () => controller.setQuantity(true),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            const Divider(),
                                            ElevatedButton(
                                              onPressed: () {
                                                controller.addItems(product);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Add to cart',
                                                style: TextStyle(fontSize: Dimensions.font26),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                      },
                    );
                  },
                  child: Text(
                    'Add to cart',
                    style: TextStyle(fontSize: Dimensions.font20),
                  ),
                ),
              ),
              SizedBox(
                width: Dimensions.height10,
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton.icon(
                  label: Text(
                    '+',
                    style: TextStyle(fontSize: Dimensions.font20),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
