import 'package:flutter/material.dart';

import 'widgets/cart_widgets.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCartHis(),
      body: cartHisBody(),
    );
  }
}
