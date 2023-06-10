// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:ihun_food_delivery/controllers/popular_product_controller.dart';
// import 'package:ihun_food_delivery/controllers/recommended_product_controller.dart';
// import 'package:ihun_food_delivery/custom/app_constants.dart';
// import 'package:ihun_food_delivery/custom/big_text.dart';
// import 'package:ihun_food_delivery/custom/dimension.dart';
// import 'package:ihun_food_delivery/custom/small_text.dart';
// import 'package:ihun_food_delivery/routes/route_helper.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _current = 0;
//   final CarouselController _controller = CarouselController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           GetBuilder<PopularProductController>(
//             builder: (popolarProducts) {

//               return

//           // SizedBox(
//           //   height: Dimensions.height30,
//           // ),
//           // GetBuilder<RecommendedProductController>(
//           //     builder: (recommendedProduct) {
//           //   return ListView.builder(
//           //     physics: const NeverScrollableScrollPhysics(),
//           //     shrinkWrap: true,
//           //     itemCount: recommendedProduct.recommendedProductList.length,
//           //     itemBuilder: (context, index) => GestureDetector(
//           //       onTap: () =>
//           //           Get.toNamed(RoutesHelper.getRecommendedFood(index, "home")),
//           //       child:

//           //       Container(
//           //         margin: EdgeInsets.only(
//           //           left: Dimensions.width20,
//           //           right: Dimensions.width20,
//           //           bottom: Dimensions.height10,
//           //         ),
//           //         child: Row(
//           //           children: [
//           //             // Images section
//           //             Container(
//           //               width: Dimensions.listViewImages,
//           //               height: Dimensions.listViewImages,
//           //               decoration: BoxDecoration(
//           //                 borderRadius: BorderRadius.circular(
//           //                   Dimensions.radius20,
//           //                 ),
//           //                 image: DecorationImage(
//           //                   fit: BoxFit.cover,
//           //                   image: NetworkImage(
//           //                       // ignore: prefer_interpolation_to_compose_strings
//           //                       "${AppConstants.BASE_URL}/uploads/" +
//           //                           recommendedProduct
//           //                               .recommendedProductList[index].img!),
//           //                 ),
//           //               ),
//           //             ),

//           //             //text container
//           //             Expanded(
//           //               child: Container(
//           //                 height: Dimensions.listViewTextConSize,
//           //                 decoration: BoxDecoration(
//           //                   borderRadius: BorderRadius.only(
//           //                     topRight: Radius.circular(Dimensions.radius20),
//           //                     bottomRight: Radius.circular(Dimensions.radius20),
//           //                   ),
//           //                   color: Colors.white,
//           //                 ),
//           //                 child: Padding(
//           //                   padding: EdgeInsets.only(
//           //                     left: Dimensions.width10,
//           //                   ),
//           //                   child: Column(
//           //                     crossAxisAlignment: CrossAxisAlignment.start,
//           //                     mainAxisAlignment: MainAxisAlignment.center,
//           //                     children: [
//           //                       BigText(
//           //                         text: recommendedProduct
//           //                             .recommendedProductList[index].name!,
//           //                       ),
//           //                       SizedBox(
//           //                         height: Dimensions.height10,
//           //                       ),
//           //                       SmallText(
//           //                           text: recommendedProduct
//           //                               .recommendedProductList[index]
//           //                               .location),
//           //                       SizedBox(
//           //                         height: Dimensions.height10,
//           //                       ),
//           //                       // const Row(
//           //                       //   mainAxisAlignment:
//           //                       //       MainAxisAlignment.spaceAround,
//           //                       //   children: [
//           //                       //     IconText(
//           //                       //       icon: Icons.circle_sharp,
//           //                       //       text: "High",
//           //                       //       iconColor: Palette.iconColor1,
//           //                       //     ),
//           //                       //     IconText(
//           //                       //       icon: Icons.location_on,
//           //                       //       text: "2.3km",
//           //                       //       iconColor: Palette.mainColor,
//           //                       //     ),
//           //                       //     IconText(
//           //                       //       icon: Icons.access_time_filled_rounded,
//           //                       //       text: "35min",
//           //                       //       iconColor: Palette.iconColor2,
//           //                       //     ),
//           //                       //   ],
//           //                       // ),
//           //                     ],
//           //                   ),
//           //                 ),
//           //               ),
//           //             ),
//           //           ],
//           //         ),
//           //       ),
//           //     ),
//           //   );
//           // })
//         ],
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihun_food_delivery/controllers/popular_product_controller.dart';
import 'package:ihun_food_delivery/controllers/recommended_product_controller.dart';
import 'package:ihun_food_delivery/custom/app_constants.dart';
import 'package:ihun_food_delivery/custom/custom_listitle.dart';
import 'package:ihun_food_delivery/routes/route_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [],
      ),
      body: GetBuilder<PopularProductController>(
        builder: (controller) {
          final List<Widget> imageSliders = controller.popularProductList
              .map((item) => GestureDetector(
                    onTap: () => Get.toNamed(RoutesHelper.getPopularFood(
                        controller.popularProductList.indexOf(item), "home")),
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                  '${AppConstants.BASE_URL}/uploads/${item.img!}',
                                  fit: BoxFit.cover,
                                  width: 1000.0),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(200, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 20.0),
                                  child: Text(
                                    '${item.name}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ))
              .toList();
          return SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  items: imageSliders,
                  carouselController: _controller,
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.popularProductList
                      .asMap()
                      .entries
                      .map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
                GetBuilder<RecommendedProductController>(
                  builder: (controller) => ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: controller.recommendedProductList.length,
                    itemBuilder: (context, index) {
                      final data = controller.recommendedProductList[index];
                      return GestureDetector(
                        onTap: () => Get.toNamed(
                            RoutesHelper.getRecommendedFood(index, "home")),
                        child: CustomListItem(
                          location: data.location!,
                          price: data.price!,
                          thumbnail: Image.network(
                            '${AppConstants.BASE_URL}/uploads/${data.img}',
                            fit: BoxFit.cover,
                            width: 150,
                            height: 100,
                          ),
                          title: data.name!,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
