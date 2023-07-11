import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_constants.dart';
import '../../model/cart_model.dart';

class CartRepo {
  final SharedPreferences share;
  CartRepo({required this.share});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCart(List<CartModel> cartList) {
    var time = DateTime.now().toString();
    cart = [];
    for (var element in cartList) {
      element.time = time;
      continue;
    }
    share.setStringList(AppConstants.CART_LIST, cart);
  }

  List<CartModel> getCartModel() {
    List<String> carts = [];
    if (share.containsKey(AppConstants.CART_LIST)) {
      carts = share.getStringList(AppConstants.CART_LIST)!;
      print("inside getCartModel$carts");
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
