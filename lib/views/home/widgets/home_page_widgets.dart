import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ihun_food_delivery/config/palettes.dart';
import 'package:ihun_food_delivery/config/text_styles.dart';
import 'package:ihun_food_delivery/controllers/popular_product_controller.dart';
import 'package:ihun_food_delivery/controllers/recommended_product_controller.dart';
import 'package:ihun_food_delivery/core/app_constants.dart';
import 'package:ihun_food_delivery/config/routes/route_helper.dart';

class PopularFoods extends StatefulWidget {
  const PopularFoods({super.key});

  @override
  State<PopularFoods> createState() => _PopularFoodsState();
}

class _PopularFoodsState extends State<PopularFoods> {
  int _current = 0;
  final CarouselController carousellController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularProductController>(
      builder: (controller) {
        final List<Widget> imageSliders = controller.popularProductList
            .map((item) => GestureDetector(
                  onTap: () =>
                      Get.toNamed(RoutesHelper.getPopularFood(controller.popularProductList.indexOf(item), "home")),
                  child: Container(
                    margin: EdgeInsets.all(5.h),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15.h)),
                        child: Stack(
                          children: <Widget>[
                            Image.network('${AppConstants.BASE_URL}/uploads/${item.img!}',
                                fit: BoxFit.cover, width: 1000.w),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                                child: Text(
                                  '${item.name}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
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

        return Column(
          children: [
            Text(
              'Popular Foods',
              style: TextStyles.customStyle.bold.setColor(Palettes.p2).appTitle,
            ),
            CarouselSlider(
              items: imageSliders,
              carouselController: carousellController,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            DotsIndicator(
              dotsCount: controller.popularProductList.length,
              position: _current,
              decorator: DotsDecorator(
                size: Size.square(5.h),
                activeSize: Size(25.w, 5.h),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.h)),
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              'Recommended Foods',
              style: TextStyles.customStyle.bold.setColor(Palettes.p2).appTitle,
            ),
          ],
        );
      },
    );
  }
}

class RecommendedFoods extends StatelessWidget {
  const RecommendedFoods({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecommendedProductController>(
      builder: (controller) => ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: controller.recommendedProductList.length,
        itemBuilder: (context, index) {
          final data = controller.recommendedProductList[index];
          return GestureDetector(
            onTap: () => Get.toNamed(RoutesHelper.getRecommendedFood(index, "home")),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomListItem(
                location: data.location!,
                price: data.price!,
                thumbnail: Container(
                  width: 150.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.h),
                    image: DecorationImage(
                        image: NetworkImage(
                          '${AppConstants.BASE_URL}/uploads/${data.img}',
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                title: data.name!,
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.location,
    required this.price,
  });

  final Widget thumbnail;
  final String title;
  final String location;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: thumbnail,
        ),
        SizedBox(
          width: 10.h,
        ),
        Expanded(
          flex: 3,
          child: _VideoDescription(
            title: title,
            location: location,
            price: price,
          ),
        ),
      ],
    );
  }
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    required this.title,
    required this.location,
    required this.price,
  });

  final String title;
  final String location;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.h, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyles.customStyle.bold.bold.setTextSize(18.sp),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 2.h)),
          Text(
            location,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 1.h)),
          Text(
            '$price\$',
          ),
        ],
      ),
    );
  }
}

PreferredSizeWidget appBarHomePage() {
  return AppBar(
    leadingWidth: 100.w,
    leading: Row(
      children: [
        SizedBox(width: 10.w),
        CircleAvatar(
          radius: 20.h,
          child: const Icon(
            Icons.person,
            color: Palettes.p1,
          ),
        ),
      ],
    ),
    actions: [
      GetBuilder<PopularProductController>(
        builder: ((controller) {
          return GestureDetector(
            onTap: () => Get.toNamed(RoutesHelper.getCart()),
            child: Icon(
              Icons.shopping_bag_rounded,
              color: Palettes.p1,
              size: 30.h,
            ),
          );
        }),
      ),
      SizedBox(width: 20.w)
    ],
  );
}
