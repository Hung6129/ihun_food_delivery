import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/cart_controller.dart';
import '/controllers/popular_product_controller.dart';
import '/controllers/recommended_product_controller.dart';
import '/custom/app_constants.dart';
import '/custom/app_icon.dart';
import '/custom/big_text.dart';
import '/custom/dimension.dart';
import '/custom/expandable_text.dart';
import '/routes/route_helper.dart';
import '/theme/palette.dart';

import 'package:badges/badges.dart' as badges;

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({
    Key? key,
    required this.pageId,
    required this.page,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 80,
              title: Row(
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
                      return (Get.find<PopularProductController>().totalItems >=
                              1
                          ? badges.Badge(
                              badgeStyle: const BadgeStyle(
                                  badgeColor: Palette.mainColor),
                              badgeAnimation:
                                  const badges.BadgeAnimation.slide(),
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
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(
                  Dimensions.height20,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    ),
                  ),
                  padding: EdgeInsets.only(
                      top: Dimensions.height5, bottom: Dimensions.height10),
                  width: double.maxFinite,
                  child: Center(
                      child: BigText(
                    text: product.name,
                    size: Dimensions.font26,
                  )),
                ),
              ),
              pinned: true,
              backgroundColor: Palette.yellowColor,
              expandedHeight: Dimensions.popularImageDetail,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URL + AppConstants.UPLOAD_URI + product.img,
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: Dimensions.width10,
                      right: Dimensions.width10,
                    ),
                    child: ExpandableText(
                      text: product.description,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20 * 2.5,
                      right: Dimensions.width20 * 2.5,
                      top: Dimensions.height10,
                      bottom: Dimensions.height10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(false);
                        },
                        child: AppIcon(
                          icon: Icons.remove,
                          iconSize: Dimensions.icon24,
                          bgColor: Palette.mainColor,
                          iconColor: Colors.white,
                        ),
                      ),
                      BigText(
                        text: "\$ ${product.price} X ${controller.inCartItems}",
                        color: Palette.mainBlackColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                          icon: Icons.add,
                          iconSize: Dimensions.icon24,
                          bgColor: Palette.mainColor,
                          iconColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
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
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Palette.mainColor,
                          size: Dimensions.icon24,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            controller.addItems(product);
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: Dimensions.height20,
                                bottom: Dimensions.height20,
                                left: Dimensions.width10,
                                right: Dimensions.width10),
                            decoration: BoxDecoration(
                              color: Palette.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: BigText(
                              text: "\$ ${product.price} | Thêm vào giỏ",
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
