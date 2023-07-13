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

PreferredSizeWidget appBarCart() {
  return AppBar(
    title: Text("Your Cart", style: TextStyles.defaultStyle.setColor(Palettes.p1).bold),
    actions: [
      Container(
        padding: const EdgeInsets.only(right: 20),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.home_rounded),
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.shopping_bag_rounded),
      ),
    ],
  );
}

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
                label: Text('Check Out', style: TextStyles.customStyle.bold.setTextSize(18.sp).setColor(Palettes.p1)),
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
            text: "The cart is Emty, try to add food",
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Container(
                  width: 90.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.h),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        AppConstants.BASE_URL + AppConstants.UPLOAD_URI + cartItem.img!,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  cartItem.name!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyles.customStyle.bold.setTextSize(16.sp).setColor(Palettes.p1),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$cartDate - $cartTime',
                      style: TextStyles.defaultStyle.setTextSize(10.sp),
                    ),
                    Text(
                      '\$${cartItem.price}',
                      style: TextStyles.defaultStyle.setTextSize(10.sp),
                    ),
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
                    SizedBox(width: 2.w),
                    Text(cartItem.quantity.toString(), style: TextStyle(fontSize: 18.sp)),
                    SizedBox(width: 2.w),
                    GestureDetector(
                      onTap: () {
                        controller.addItems(cartItem.productModel!, 1);
                      },
                      child: const Icon(Icons.add, color: Palettes.p3),
                    ),
                  ],
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
    title: Text("Your Order", style: TextStyles.defaultStyle.setColor(Palettes.p1).bold),
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

  // List<String> cartOrderTimeToList() {
  //   return cartItemsPerOrder.entries.map((e) => e.key).toList();
  // }

  List<int> itemsPerOrder = cartItemsitemsPerOrder();
  var saveCounter = 0;
  return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      itemCount: itemsPerOrder.length,
      itemBuilder: (context, i) => Container(
            margin: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    GestureDetector(
                      onTap: () {
                        // var orderTime = cartOrderTimeToList();
                        // Map<int, CartModel> seeMore = {};
                        // for (var j = 0; j < getCartHistoryList.length; j++) {
                        //   if (getCartHistoryList[j].time == orderTime[i]) {
                        //     seeMore.putIfAbsent(getCartHistoryList[j].id!,
                        //         () => CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]))));
                        //   }
                        // }
                        // Get.find<CartController>().setItems = seeMore;
                        // Get.find<CartController>().addToCartList();
                        // Get.toNamed(RoutesHelper.getCart());
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            border: Border.all(width: 1, color: Palettes.p1),
                          ),
                          child: const Text("View Detail", style: TextStyle(color: Palettes.p1))),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: itemsPerOrder[i],
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(right: 10.w, bottom: 10.h),
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    AppConstants.BASE_URL + AppConstants.UPLOAD_URI + getCartHistoryList[index].img!,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              "${getCartHistoryList[index].quantity} x ${getCartHistoryList[index].name!}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyles.customStyle.bold.setTextSize(12.sp).setColor(Palettes.textBlack),
                            ),
                          )
                        ],
                      );
                    })
              ],
            ),
          ));
}
