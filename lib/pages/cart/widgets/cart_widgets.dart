import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ihun_food_delivery/config/no_data_page.dart';
import 'package:ihun_food_delivery/config/palettes.dart';
import 'package:ihun_food_delivery/config/text_styles.dart';
import 'package:ihun_food_delivery/controllers/cart_controller.dart';
import 'package:intl/intl.dart';

Widget bottomSheetCart() {
  return Container(
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.h), topRight: Radius.circular(30.h)),
      ),
      color: Palettes.p4,
    ),
    width: double.maxFinite,
    height: 100.h,
    child: GetBuilder<CartController>(
      builder: (controller) => Padding(
        padding: EdgeInsets.all(10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Total: \$${controller.totalAmount}",
                style: TextStyles.customStyle.bold.setTextSize(18.sp).setColor(Palettes.p1),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(15.h)),
                    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18.sp))),
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
  );
}

Widget cartBody() {
  return GetBuilder<CartController>(
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
                      style: TextStyles.customStyle.bold.setTextSize(18.sp).setColor(Palettes.p1),
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
                          child: const Icon(Icons.remove, color: Palettes.p3),
                        ),
                        SizedBox(width: 5.w),
                        Text(cartItem.quantity.toString(), style: TextStyle(fontSize: 18.sp)),
                        SizedBox(width: 5.w),
                        GestureDetector(
                          onTap: () {
                            controller.addItems(cartItem.productModel!, 1);
                          },
                          child: const Icon(Icons.add, color: Palettes.p3),
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
  );
}
