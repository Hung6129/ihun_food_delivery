import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ihun_food_delivery/config/palettes.dart';
import 'package:intl/intl.dart';

import '../../controllers/cart_controller.dart';
import '../../custom/app_constants.dart';
import '../../custom/big_text.dart';
import '../../custom/dimension.dart';
import '../../custom/small_text.dart';
import '../../model/cart_model.dart';
import '../../config/routes/route_helper.dart';


class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
              child: ListView(
                children: [
                  for (int i = 0; i < itemsPerOrder.length; i++)
                    Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (() {
                            DateTime parseTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[saveCounter].time!);
                            var output = DateFormat("dd/MM/yyyy hh:mm a");
                            var outDate = output.format(parseTime);
                            return BigText(text: outDate);
                          }()),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
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
                                            margin: EdgeInsets.only(left: Dimensions.width10),
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  AppConstants.BASE_URL + AppConstants.UPLOAD_URI + getCartHistoryList[saveCounter - 1].img!,
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
                                  const SmallText(text: "Total"),
                                  BigText(text: "${itemsPerOrder[i]} Items"),
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
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10, vertical: Dimensions.height10 / 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                        border: Border.all(width: 1, color: Palettes.p1),
                                      ),
                                      child: const SmallText(text: "See more"),
                                    ),
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
      ),
    );
  }
}
