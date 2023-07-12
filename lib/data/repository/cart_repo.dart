import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_constants.dart';
import '../../model/cart_model.dart';

class CartRepo {
  final SharedPreferences share;
  CartRepo({
    required this.share,
  });

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    var time = DateTime.now().toString();
    cart = [];
    for (var element in cartList) {
      element.time = time;
      cart.add(jsonEncode(element));
    }
    share.setStringList(AppConstants.CART_LIST, cart);
    getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (share.containsKey(AppConstants.CART_LIST)) {
      carts = share.getStringList(AppConstants.CART_LIST)!;
    }
    List<CartModel> cartList = [];
    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (share.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory = share.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartListHistory;
  }

  void addToCartHistory() {
    if (share.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = share.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("list ${cart[i]}");
      cartHistory.add(cart[i]);
    }
    removeCart();
    share.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  void removeCart() {
    cart = [];
    share.remove(AppConstants.CART_LIST);
  }
}
