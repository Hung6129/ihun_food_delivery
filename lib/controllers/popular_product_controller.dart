import 'package:ihun_food_delivery/config/widgets/flutter_toast.dart';
import '/controllers/cart_controller.dart';
import '/data/repository/popular_product_repo.dart';
import '../data/model/cart_model.dart';
import '../data/model/product.dart';

import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
// set product to a list
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  // items quantity for detail pages
  int _quantity = 0;
  int get quantity => _quantity;

  // items quantity in cart
  int _intCartItems = 0;
  int get inCartItems => _intCartItems + _quantity;

  // var
  late CartController _cartController;

  //get data from product model
  Future<void> getPopularProductList() async {
    Response res = await popularProductRepo.getPopularProductList();
    if (res.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(res.body).products);
      //set state
      update();
    } else {}
  }

  // set increase and decrease for add items to cart
  void setQuantity(bool isIncrement) {
    if (isIncrement == true) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

// check quantity for decrease more than 1 items
  int checkQuantity(int quantity) {
    if ((_intCartItems + quantity) < 0) {
      toastInfor(text: "You can't decrease more than 1 items");
      if (_intCartItems > 0) {
        _quantity = -_intCartItems;
        return _quantity;
      }
      return 0;
    } else {
      return quantity;
    }
  }

// set items quantity in cart
  void initProduct(ProductModel productModel, CartController cartController) {
    _quantity = 0;
    _intCartItems = 0;
    _cartController = cartController;
    var exist = false;
    exist = _cartController.existInCart(productModel);
    if (exist) {
      _intCartItems = _cartController.getQuantity(productModel);
    }
    print("the quantity is $_intCartItems");
  }

  // add items
  void addItems(ProductModel productModel) {
    _cartController.addItems(productModel, _quantity);
    _quantity = 0;
    _intCartItems = _cartController.getQuantity(productModel);
    _cartController.items.forEach((key, value) {
      print("the id is ${value.id} the quantity is ${value.quantity}");
    });
    update();
  }

  int get totalItems {
    return _cartController.totalItems;
  }

  List<CartModel> get getItems {
    return _cartController.getItems;
  }
}
