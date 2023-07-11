import 'package:flutter/material.dart';

import 'package:ihun_food_delivery/pages/cart/widgets/cart_widgets.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: cartBody(),
      bottomSheet: bottomSheetCart(),
    );
  }
}
