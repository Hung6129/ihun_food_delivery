import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ihun_food_delivery/config/no_data_page.dart';
import 'package:ihun_food_delivery/config/palettes.dart';
import 'package:ihun_food_delivery/config/routes/route_helper.dart';
import 'package:ihun_food_delivery/config/text_styles.dart';
import 'package:ihun_food_delivery/controllers/cart_controller.dart';
import 'package:ihun_food_delivery/core/app_constants.dart';
import 'package:ihun_food_delivery/model/cart_model.dart';
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

PreferredSizeWidget appBarCartHis() {
  return AppBar(
    title: const Text("Cart History"),
    actions: [
      Container(
        padding: const EdgeInsets.only(right: 20),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart_rounded),
        ),
      ),
    ],
  );
}

Widget cartHisBody() {
  var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
  Map<String, int> cartItemsPerOrder = {};
  for (int i = 0; i < getCartHistoryList.length; i++) {
    if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
      cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
    } else {
      cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
    }
  }

  List<int> cartItemsitemsPerOrder() {
    return cartItemsPerOrder.entries.map((e) => e.value).toList();
  }

  List<String> cartOrderTimeToList() {
    return cartItemsPerOrder.entries.map((e) => e.key).toList();
  }

  List<int> itemsPerOrder = cartItemsitemsPerOrder();
  var saveCounter = 0;
  return Column(
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
          child: ListView(
            children: [
              for (int i = 0; i < itemsPerOrder.length; i++)
                Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (() {
                        DateTime parseTime =
                            DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[saveCounter].time!);
                        var output = DateFormat("dd/MM/yyyy hh:mm a");
                        var outDate = output.format(parseTime);
                        return Text(
                          outDate,
                          style: TextStyles.customStyle.bold.setTextSize(18.sp).setColor(Palettes.p1),
                        );
                      }()),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            children: List.generate(
                              itemsPerOrder[i],
                              (index) {
                                if (saveCounter < getCartHistoryList.length) {
                                  saveCounter++;
                                }
                                return index <= 1
                                    ? Container(
                                        margin: EdgeInsets.only(left: 10.w),
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.h),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              AppConstants.BASE_URL +
                                                  AppConstants.UPLOAD_URI +
                                                  getCartHistoryList[saveCounter - 1].img!,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Price",
                                style: TextStyles.defaultStyle.copyWith(color: Palettes.p1).bold,
                              ),
                              Text("${itemsPerOrder[i]} Items"),
                              GestureDetector(
                                onTap: () {
                                  var orderTime = cartOrderTimeToList();
                                  Map<int, CartModel> seeMore = {};
                                  for (var j = 0; j < getCartHistoryList.length; j++) {
                                    if (getCartHistoryList[j].time == orderTime[i]) {
                                      seeMore.putIfAbsent(
                                          getCartHistoryList[j].id!,
                                          () => CartModel.fromJson(jsonDecode(jsonEncode(
                                                getCartHistoryList[j],
                                              ))));
                                    }
                                  }
                                  Get.find<CartController>().setItems = seeMore;
                                  Get.find<CartController>().addToCartList();
                                  Get.toNamed(RoutesHelper.getCart());
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.h),
                                      border: Border.all(width: 1, color: Palettes.p1),
                                    ),
                                    child: const Text("See More", style: TextStyle(color: Palettes.p1))),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      )
    ],
  );
}
