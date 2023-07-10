import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihun_food_delivery/base/no_data_page.dart';
import 'package:ihun_food_delivery/controllers/cart_controller.dart';
import 'package:ihun_food_delivery/controllers/popular_product_controller.dart';
import 'package:ihun_food_delivery/controllers/recommended_product_controller.dart';
import 'package:ihun_food_delivery/custom/big_text.dart';
import 'package:ihun_food_delivery/custom/dimension.dart';
import 'package:ihun_food_delivery/routes/route_helper.dart';
import 'package:ihun_food_delivery/theme/palette.dart';
import 'package:intl/intl.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: GetBuilder<CartController>(
        builder: (controller) {
          final listCart = controller.getItems;
          if (listCart.isEmpty) {
            return const Center(
              child: NodataPage(
                text: "Cart is Emty, try to add food",
                imagePath: "assets/image/empty_cart.png",
              ),
            );
          } else {
            return ListView.builder(
              itemCount: listCart.length,
              itemBuilder: (context, index) {
                final cartItem = listCart[index];
                final dateTime = DateTime.parse(cartItem.time!);
                final cartDate = DateFormat.MMMEd().format(dateTime);
                final cartTime = DateFormat.jm().format(dateTime);
                return GestureDetector(
                  onTap: () {
                    // final ppfIndex =
                    //     Get.find<PopularProductController>().popularProductList.indexOf(cartItem.productModel!);
                    // if (ppfIndex >= 0) {
                    //   Get.toNamed(RoutesHelper.getPopularFood(ppfIndex));
                    // } else {
                    //   final refIndex = Get.find<RecommendedProductController>()
                    //       .recommendedProductList
                    //       .indexOf(cartItem.productModel!);
                    //   Get.toNamed(RoutesHelper.getPopularFood(refIndex));
                    // }
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          cartItem.name!,
                          style: TextStyle(fontSize: Dimensions.font20),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$cartDate - $cartTime'),
                            Text('\$${cartItem.price}'),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.addItems(cartItem.productModel!, -1);
                              },
                              child: const Icon(
                                Icons.remove,
                                color: Palette.signColor,
                              ),
                            ),
                            SizedBox(width: Dimensions.width10 / 2),
                            BigText(
                              text: cartItem.quantity!.toString(),
                            ),
                            SizedBox(width: Dimensions.width10 / 2),
                            GestureDetector(
                              onTap: () {
                                controller.addItems(cartItem.productModel!, 1);
                              },
                              child: const Icon(
                                Icons.add,
                                color: Palette.signColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
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
        child: GetBuilder<CartController>(
          builder: (controller) => Padding(
            padding: EdgeInsets.all(Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Total: \$${controller.totalAmount}",
                    style: TextStyle(fontSize: Dimensions.font20),
                  ),
                ),
                SizedBox(
                  width: Dimensions.height10,
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20))),
                    label: const Text('Check Out'),
                    icon: const Icon(Icons.attach_money),
                    onPressed: () {
                      controller.addToHistory();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
