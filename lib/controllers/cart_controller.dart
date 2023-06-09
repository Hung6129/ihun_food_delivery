import 'package:flutter/material.dart';
import '/data/repository/cart_repo.dart';
import '/model/cart_model.dart';
import '/model/product.dart';
import '/theme/palette.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({
    required this.cartRepo,
  });

  //create a map to store a local varibles
  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  // local storage
  List<CartModel> storageModel = [];

  // add to cart
  void addItems(ProductModel productModel, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(productModel.id!)) {
      _items.update(productModel.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          img: value.img,
          name: value.name,
          price: value.price,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          productModel: productModel,
        );
      });

      // remove it if totalQuantity of product is 0
      if (totalQuantity <= 0) {
        _items.remove(productModel.id);
      }
      //
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(productModel.id!, () {
          return CartModel(
            id: productModel.id,
            img: productModel.img,
            name: productModel.name,
            price: productModel.price,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            productModel: productModel,
          );
        });
      } else {
        Get.snackbar(
          "Bruh",
          "Your quantity have to at least one",
          colorText: Colors.black,
          backgroundColor: Palette.yellowColor,
        );
      }
    }
    cartRepo.addToCart(getItems);
    update();
  }

  bool existInCart(ProductModel productModel) {
    if (_items.containsKey(productModel.id)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

// get total items
  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;
    _items.forEach((key, value) {
      total = value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartModel();
    return storageModel;
  }

  set setCart(List<CartModel> items) {
    storageModel = items;
    print("length of cart items${storageModel.length}");
    for (int i = 0; i < storageModel.length; i++) {
      _items.putIfAbsent(
          storageModel[i].productModel!.id!, () => storageModel[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistory();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCart(getItems);
    update();
  }
}
