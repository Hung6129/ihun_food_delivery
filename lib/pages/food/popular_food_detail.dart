import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/cart_controller.dart';
import '/controllers/popular_product_controller.dart';
import '/custom/app_column.dart';
import '/custom/app_constants.dart';
import '/custom/app_icon.dart';
import '/custom/big_text.dart';
import '/custom/dimension.dart';
import '/custom/expandable_text.dart';
import '/routes/route_helper.dart';
import '/theme/palette.dart';

import 'package:badges/badges.dart' as badges;

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //popular product detail varibles
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //bground images
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularImageDetail,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URI +
                        product.img!),
                    fit: BoxFit.cover),
              ),
            ),
          ),

          //icon button
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == "cartPage") {
                      Get.toNamed(RoutesHelper.getCart());
                    } else {
                      Get.toNamed(RoutesHelper.getInitial());
                    }
                  },
                  child: const AppIcon(icon: Icons.arrow_back_ios),
                ),
                GetBuilder<PopularProductController>(
                  builder: ((controller) {
                    return (Get.find<PopularProductController>().totalItems >= 1
                        ? badges.Badge(
                            badgeStyle:
                                const BadgeStyle(badgeColor: Palette.mainColor),
                            badgeAnimation: const badges.BadgeAnimation.slide(),
                            badgeContent: controller.totalItems >= 1
                                ? BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: Dimensions.font14,
                                  )
                                : Container(),
                            child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(RoutesHelper.getCart());
                                },
                                child: const AppIcon(
                                    icon: Icons.shopping_cart_outlined)),
                          )
                        : GestureDetector(
                            onTap: () {
                              Get.toNamed(RoutesHelper.cartPage);
                            },
                            child: const AppIcon(
                                icon: Icons.shopping_cart_outlined)));
                  }),
                )
              ],
            ),
          ),

          //introduction of food
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularImageDetail - 50,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    star: product.stars!,
                    smallText1: "${product.stars}",
                    bigText: product.name!,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  const BigText(text: "Giới thiệu"),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableText(
                        text: product.description!,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),

      //bottom bar for detail food page
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            height: Dimensions.bottomHeight,
            padding: EdgeInsets.only(
                top: Dimensions.height20,
                bottom: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
              color: Palette.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20),
                topRight: Radius.circular(Dimensions.radius20),
              ),
            ),

            // 2 bottom buttons
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: const Icon(
                          Icons.remove,
                          color: Palette.signColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(
                        text: popularProduct.inCartItems.toString(),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: const Icon(
                          Icons.add,
                          color: Palette.signColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                  ),
                  decoration: BoxDecoration(
                    color: Palette.mainColor,
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius20,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      popularProduct.addItems(product);
                    },
                    child: BigText(
                      text: "\$ ${product.price} | Thêm vào giỏ",
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
