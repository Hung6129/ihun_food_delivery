import 'package:flutter/material.dart';
import '/custom/big_text.dart';
import '/custom/dimension.dart';
import '/custom/small_text.dart';
import '/theme/palette.dart';

import 'food_page_body.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: Dimensions.height45,
              bottom: Dimensions.height15,
            ),
            padding: EdgeInsets.only(
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    BigText(
                      text: "Hưng Nguyễn",
                      color: Palette.mainColor,
                    ),
                    Row(
                      children: [
                        SmallText(
                          text: "Thêm",
                          color: Colors.black54,
                        ),
                        Icon(
                          Icons.arrow_drop_down_rounded,
                        )
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: Dimensions.width45,
                    height: Dimensions.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius15,
                      ),
                      color: Palette.mainColor,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.icon24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //for body
          const Expanded(
            child: SingleChildScrollView(
              child: FoodPageBody(),
            ),
          ),
        ],
      ),
    );
  }
}
