import 'package:flutter/material.dart';
import '../../base/no_data_page.dart';
import '/controllers/popular_product_controller.dart';
import '/controllers/recommended_product_controller.dart';
import '/controllers/cart_controller.dart';
import '/custom/app_constants.dart';
import '/custom/app_icon.dart';
import '/custom/big_text.dart';
import '/custom/dimension.dart';
import '/custom/small_text.dart';
import '/routes/route_helper.dart';
import '/theme/palette.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // header buttons
          Positioned(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height20 * 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    iconSize: Dimensions.icon16,
                    bgColor: Palette.mainColor,
                  ),
                ),
                SizedBox(
                  width: Dimensions.width20 * 5,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RoutesHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    iconSize: Dimensions.icon24,
                    bgColor: Palette.mainColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    iconSize: Dimensions.icon24,
                    bgColor: Palette.mainColor,
                  ),
                ),
              ],
            ),
          ),
          // list product added to cart
          Positioned(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height20 * 5,
            bottom: 0,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: GetBuilder<CartController>(
                builder: (controller) {
                  var cartItem = controller.getItems;
                  return cartItem.isEmpty
                      ? const NodataPage(
                          text: "Your cart is Emty",
                          imagePath: "assets/image/empty_cart.png")
                      : ListView.builder(
                          itemCount: cartItem.length,
                          itemBuilder: (_, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: Dimensions.height20 * 5,
                              width: double.maxFinite,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      var pplIndex =
                                          Get.find<PopularProductController>()
                                              .popularProductList
                                              .indexOf(cartItem[index]
                                                  .productModel!);
                                      if (pplIndex >= 0) {
                                        Get.toNamed(RoutesHelper.getPopularFood(
                                            pplIndex, "cartPage"));
                                      } else {
                                        var recomIndex = Get.find<
                                                RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(
                                                cartItem[index].productModel!);
                                        if (recomIndex < 0) {
                                          Get.snackbar(
                                            "History Product",
                                            "Not availible",
                                            colorText: Colors.white,
                                            backgroundColor: Colors.red,
                                          );
                                        } else {
                                          Get.toNamed(
                                              RoutesHelper.getRecommendedFood(
                                                  recomIndex, "cartPage"));
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: Dimensions.width20 * 5,
                                      height: Dimensions.height20 * 5,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(AppConstants
                                                  .BASE_URL +
                                              AppConstants.UPLOAD_URI +
                                              controller.getItems[index].img!),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.width10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: cartItem[index].name!),
                                        SmallText(text: cartItem[index].time!),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text:
                                                  "\$${cartItem[index].price}",
                                              size: Dimensions.font16,
                                              color: Colors.redAccent,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                top: Dimensions.height10,
                                                bottom: Dimensions.height10,
                                                left: Dimensions.width10,
                                                right: Dimensions.width10,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      // popularProduct
                                                      //     .setQuantity(false);
                                                    },
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        controller.addItems(
                                                            cartItem[index]
                                                                .productModel!,
                                                            -1);
                                                      },
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color:
                                                            Palette.signColor,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2),
                                                  BigText(
                                                    text: cartItem[index]
                                                        .quantity!
                                                        .toString(),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.addItems(
                                                          cartItem[index]
                                                              .productModel!,
                                                          1);
                                                    },
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: Palette.signColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (controller) {
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
            child: controller.getItems.isEmpty
                ? Container()
                : Row(
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
                        child: Row(
                          children: [
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                            BigText(
                              text: "\$ ${controller.totalAmount.toString()}",
                            ),
                            SizedBox(
                              width: Dimensions.width10 / 2,
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
                            controller.addToHistory();
                          },
                          child: const BigText(
                            text: "Check out",
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
