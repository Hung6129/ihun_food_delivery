import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:ihun_food_delivery/custom/icon_text.dart';
import '/controllers/popular_product_controller.dart';
import '/controllers/recommended_product_controller.dart';
import '/custom/app_column.dart';
import '/custom/app_constants.dart';
import '/custom/big_text.dart';
import '/custom/dimension.dart';

import '/custom/small_text.dart';
import '/model/product.dart';
import '/routes/route_helper.dart';
import '/theme/palette.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValues = 0.0;
  final double _scaleFactor = 0.8;
  final double _currHeight = Dimensions.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValues = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider
        GetBuilder<PopularProductController>(builder: (popolarProducts) {
          return SizedBox(
            height: Dimensions.pageView,
            child: PageView.builder(
                controller: pageController,
                itemCount: popolarProducts.popularProductList.length,
                itemBuilder: (context, postion) {
                  return _buildPageItem(
                      postion, popolarProducts.popularProductList[postion]);
                }),
          );
        }),

        //dots
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return DotsIndicator(
            dotsCount: popularProduct.popularProductList.isEmpty
                ? 1
                : popularProduct.popularProductList.length,
            position: _currPageValues.toInt(),
            decorator: DotsDecorator(
              activeColor: Palette.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          );
        }),

        //popular list, text
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const BigText(text: "Đề xuất"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: const BigText(text: "."),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              const SmallText(text: "Mlem mlem")
            ],
          ),
        ),

        //list of food and items
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recommendedProduct.recommendedProductList.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () =>
                  Get.toNamed(RoutesHelper.getRecommendedFood(index, "home")),
              child: Container(
                margin: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: Dimensions.height10,
                ),
                child: Row(
                  children: [
                    // Images section
                    Container(
                      width: Dimensions.listViewImages,
                      height: Dimensions.listViewImages,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Dimensions.radius20,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              // ignore: prefer_interpolation_to_compose_strings
                              "${AppConstants.BASE_URL}/uploads/" +
                                  recommendedProduct
                                      .recommendedProductList[index].img!),
                        ),
                      ),
                    ),

                    //text container
                    Expanded(
                      child: Container(
                        height: Dimensions.listViewTextConSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.radius20),
                            bottomRight: Radius.circular(Dimensions.radius20),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: Dimensions.width10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(
                                text: recommendedProduct
                                    .recommendedProductList[index].name!,
                              ),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              SmallText(
                                  text: recommendedProduct
                                      .recommendedProductList[index].location),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconText(
                                    icon: Icons.circle_sharp,
                                    text: "High",
                                    iconColor: Palette.iconColor1,
                                  ),
                                  IconText(
                                    icon: Icons.location_on,
                                    text: "2.3km",
                                    iconColor: Palette.mainColor,
                                  ),
                                  IconText(
                                    icon: Icons.access_time_filled_rounded,
                                    text: "35min",
                                    iconColor: Palette.iconColor2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        })
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProductList) {
    Matrix4 matrix4 = Matrix4.identity();
    //slider custom view
    if (index == _currPageValues.floor()) {
      var currScale = 1 - (_currPageValues - index) * (1 - _scaleFactor);
      var currTrans = _currHeight * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValues.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValues - index + 1) * (1 - _scaleFactor);
      var currTrans = _currHeight * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValues.floor() + 1) {
      var currScale = 1 - (_currPageValues - index) * (1 - _scaleFactor);
      var currTrans = _currHeight * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _currHeight * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Get.toNamed(
              RoutesHelper.getPopularFood(index, "home"),
            ),
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven ? Palette.mainColor : Palette.signColor,
                image: DecorationImage(
                  image: NetworkImage(
                      "${AppConstants.BASE_URL}/uploads/${popularProductList.img!}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height15,
                  left: Dimensions.width15,
                  right: Dimensions.width15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                        bigText: popularProductList.name!,
                        smallText1: "${popularProductList.stars!}",
                        star: popularProductList.stars!),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
