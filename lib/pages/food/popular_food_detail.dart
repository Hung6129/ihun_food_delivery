// import 'package:badges/badges.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '/controllers/cart_controller.dart';
// import '/controllers/popular_product_controller.dart';
// import '/custom/app_column.dart';
// import '/custom/app_constants.dart';
// import '/custom/app_icon.dart';
// import '/custom/big_text.dart';
// import '/custom/dimension.dart';
// import '/custom/expandable_text.dart';
// import '/routes/route_helper.dart';
// import '/theme/palette.dart';

// import 'package:badges/badges.dart' as badges;

// class PopularFoodDetail extends StatelessWidget {
//   final int pageId;
//   final String page;
//   const PopularFoodDetail({
//     Key? key,
//     required this.pageId,
//     required this.page,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //popular product detail varibles
//     var product =
//         Get.find<PopularProductController>().popularProductList[pageId];
//     Get.find<PopularProductController>()
//         .initProduct(product, Get.find<CartController>());
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           //bground images
//           Positioned(
//             left: 0,
//             right: 0,
//             child:
// Container(
//               width: double.maxFinite,
//               height: Dimensions.popularImageDetail,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: NetworkImage(AppConstants.BASE_URL +
//                         AppConstants.UPLOAD_URI +
//                         product.img!),
//                     fit: BoxFit.cover),
//               ),
//             ),
//           ),

//           //icon button
//           Positioned(
//             top: Dimensions.height45,
//             left: Dimensions.width20,
//             right: Dimensions.width20,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     if (page == "cartPage") {
//                       Get.toNamed(RoutesHelper.getCart());
//                     } else {
//                       Get.toNamed(RoutesHelper.getInitial());
//                     }
//                   },
//                   child: const AppIcon(icon: Icons.arrow_back_ios),
//                 ),
//                 GetBuilder<PopularProductController>(
//                   builder: ((controller) {
//                     return (Get.find<PopularProductController>().totalItems >= 1
//                         ? badges.Badge(
//                             badgeStyle:
//                                 const BadgeStyle(badgeColor: Palette.mainColor),
//                             badgeAnimation: const badges.BadgeAnimation.slide(),
//                             badgeContent: controller.totalItems >= 1
//                                 ? BigText(
//                                     text: Get.find<PopularProductController>()
//                                         .totalItems
//                                         .toString(),
//                                     size: Dimensions.font14,
//                                   )
//                                 : Container(),
//                             child: GestureDetector(
//                                 onTap: () {
//                                   Get.toNamed(RoutesHelper.getCart());
//                                 },
//                                 child: const AppIcon(
//                                     icon: Icons.shopping_cart_outlined)),
//                           )
//                         : GestureDetector(
//                             onTap: () {
//                               Get.toNamed(RoutesHelper.cartPage);
//                             },
//                             child: const AppIcon(
//                                 icon: Icons.shopping_cart_outlined)));
//                   }),
//                 )
//               ],
//             ),
//           ),

//           //introduction of food
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             top: Dimensions.popularImageDetail - 50,
//             child: Container(
//               padding: EdgeInsets.only(
//                   left: Dimensions.width20,
//                   right: Dimensions.width20,
//                   top: Dimensions.height20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(Dimensions.radius20),
//                   topRight: Radius.circular(Dimensions.radius20),
//                 ),
//                 color: Colors.white,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   AppColumn(
//                     star: product.stars!,
//                     smallText1: "${product.stars}",
//                     bigText: product.name!,
//                   ),
//                   SizedBox(
//                     height: Dimensions.height20,
//                   ),
//                   const BigText(text: "Giới thiệu"),
//                   SizedBox(
//                     height: Dimensions.height20,
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: ExpandableText(
//                         text: product.description!,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),

//       //bottom bar for detail food page
//       bottomNavigationBar: GetBuilder<PopularProductController>(
//         builder: (popularProduct) {
//           return Container(
//             height: Dimensions.bottomHeight,
//             padding: EdgeInsets.only(
//                 top: Dimensions.height20,
//                 bottom: Dimensions.height20,
//                 left: Dimensions.width20,
//                 right: Dimensions.width20),
//             decoration: BoxDecoration(
//               color: Palette.buttonBackgroundColor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(Dimensions.radius20),
//                 topRight: Radius.circular(Dimensions.radius20),
//               ),
//             ),

//             // 2 bottom buttons
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(
//                     top: Dimensions.height20,
//                     bottom: Dimensions.height20,
//                     left: Dimensions.width10,
//                     right: Dimensions.width10,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(Dimensions.radius20),
//                     color: Colors.white,
//                   ),
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           popularProduct.setQuantity(false);
//                         },
//                         child: const Icon(
//                           Icons.remove,
//                           color: Palette.signColor,
//                         ),
//                       ),
//                       SizedBox(
//                         width: Dimensions.width10 / 2,
//                       ),
//                       BigText(
//                         text: popularProduct.inCartItems.toString(),
//                       ),
//                       SizedBox(
//                         width: Dimensions.width10 / 2,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           popularProduct.setQuantity(true);
//                         },
//                         child: const Icon(
//                           Icons.add,
//                           color: Palette.signColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.only(
//                     top: Dimensions.height20,
//                     bottom: Dimensions.height20,
//                     left: Dimensions.width10,
//                     right: Dimensions.width10,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Palette.mainColor,
//                     borderRadius: BorderRadius.circular(
//                       Dimensions.radius20,
//                     ),
//                   ),
//                   child: GestureDetector(
//                     onTap: () {
//                       popularProduct.addItems(product);
//                     },
//                     child: BigText(
//                       text: "\$ ${product.price} | Thêm vào giỏ",
//                       color: Colors.white,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihun_food_delivery/controllers/cart_controller.dart';
import 'package:ihun_food_delivery/controllers/popular_product_controller.dart';
import 'package:ihun_food_delivery/custom/app_constants.dart';
import 'package:ihun_food_delivery/custom/app_icon.dart';
import 'package:ihun_food_delivery/custom/big_text.dart';
import 'package:ihun_food_delivery/custom/dimension.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ihun_food_delivery/routes/route_helper.dart';
import 'package:ihun_food_delivery/theme/palette.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({
    super.key,
    required this.pageId,
    required this.page,
  });
  final int pageId;
  final String page;
  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            expandedHeight: 280,
            stretch: true,
            actions: [
              GetBuilder<PopularProductController>(
                builder: ((controller) {
                  return (Get.find<PopularProductController>().totalItems >= 1
                      ? badges.Badge(
                          badgeStyle: const BadgeStyle(badgeColor: Palette.mainColor),
                          badgeAnimation: const badges.BadgeAnimation.slide(),
                          badgeContent: controller.totalItems >= 1
                              ? BigText(
                                  text: Get.find<PopularProductController>().totalItems.toString(),
                                  size: Dimensions.font14,
                                )
                              : const SizedBox(),
                          child: GestureDetector(
                              onTap: () {
                                Get.toNamed(RoutesHelper.getCart());
                              },
                              child: const AppIcon(icon: Icons.shopping_cart_outlined)),
                        )
                      : GestureDetector(
                          onTap: () {
                            Get.toNamed(RoutesHelper.cartPage);
                          },
                          child: const AppIcon(icon: Icons.shopping_cart_outlined)));
                }),
              ),
              SizedBox(width: Dimensions.height20)
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: CachedNetworkImage(
                imageUrl: AppConstants.BASE_URL + AppConstants.UPLOAD_URI + product.img!,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.name!,
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(product.description!),
              ),
            ],
          )),
        ],
      ),
      bottomSheet: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                Dimensions.height30,
              ),
              topRight: Radius.circular(
                Dimensions.height30,
              ),
            ),
          ),
          color: Palette.mainColor,
        ),
        width: double.maxFinite,
        height: Dimensions.bottomSheet,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return GetBuilder<PopularProductController>(
                            builder: (controller) => SizedBox(
                                  height: 300,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              child: const Text(
                                                '-',
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              onPressed: () => controller.setQuantity(false),
                                            ),
                                            SizedBox(
                                              width: Dimensions.height15,
                                            ),
                                            Text(
                                              controller.inCartItems.toString(),
                                              style: const TextStyle(fontSize: 30),
                                            ),
                                            SizedBox(
                                              width: Dimensions.height15,
                                            ),
                                            ElevatedButton(
                                              child: const Text(
                                                '+',
                                                style: TextStyle(fontSize: 30),
                                              ),
                                              onPressed: () => controller.setQuantity(true),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            const Divider(),
                                            ElevatedButton(
                                              onPressed: () {
                                                controller.addItems(product);
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Add to cart',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                      },
                    );
                  },
                  child: const Text(
                    'Add to cart',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton.icon(
                  label: const Text(
                    '+',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
