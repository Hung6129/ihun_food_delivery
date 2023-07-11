import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ihun_food_delivery/config/palettes.dart';
import 'package:ihun_food_delivery/config/routes/route_helper.dart';
import 'package:ihun_food_delivery/config/text_styles.dart';
import 'package:ihun_food_delivery/controllers/popular_product_controller.dart';
import 'package:ihun_food_delivery/core/app_constants.dart';
import 'package:ihun_food_delivery/model/product.dart';
import 'package:badges/badges.dart' as badges;

Future showAddToCartDialog(BuildContext context, ProductModel product) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return GetBuilder<PopularProductController>(
          builder: (controller) => SizedBox(
                height: 280.h,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: Text(
                        'Adding ${product.name!} to your cart',
                        style: TextStyle(fontSize: 17.sp),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text(
                              '-',
                              style: TextStyle(fontSize: 26.sp),
                            ),
                            onPressed: () => controller.setQuantity(false),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(controller.inCartItems.toString(), style: TextStyle(fontSize: 26.sp)),
                          SizedBox(width: 15.w),
                          ElevatedButton(
                            child: Text('+', style: TextStyle(fontSize: 26.sp)),
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.all(10.h)),
                                    backgroundColor: MaterialStateProperty.all(Palettes.p2)),
                                child: Text('Add To Cart', style: TextStyle(color: Colors.white, fontSize: 18.sp)),
                                onPressed: () {
                                  controller.addItems(product);
                                  Navigator.pop(context);
                                },
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(EdgeInsets.all(10.h)),
                                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
    },
  );
}

Widget bottomSheetFoodDetailToCart(BuildContext context, ProductModel product) {
  return Container(
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.h),
          topRight: Radius.circular(30.h),
        ),
      ),
      color: Palettes.p4,
    ),
    width: double.maxFinite,
    height: 100.h,
    child: Padding(
      padding: EdgeInsets.all(10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15.h)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18.sp))),
              onPressed: () {
                showAddToCartDialog(context, product);
              },
              child: const Text(
                'Add To Cart',
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            flex: 1,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.all(15.h)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18.sp))),
              label: const Text('+'),
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget sliverAppBarFoodDetail(ProductModel product) {
  return SliverAppBar(
    pinned: true,
    snap: false,
    floating: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30.h),
      ),
    ),
    expandedHeight: 280.h,
    stretch: true,
    actions: [
      GetBuilder<PopularProductController>(
        builder: ((controller) {
          return Get.find<PopularProductController>().totalItems >= 1
              ? GestureDetector(
                  onTap: () => Get.toNamed(RoutesHelper.getCart()),
                  child: badges.Badge(
                    badgeStyle: const badges.BadgeStyle(badgeColor: Palettes.p2),
                    badgeAnimation: const badges.BadgeAnimation.slide(),
                    badgeContent: controller.totalItems >= 1
                        ? Text(
                            controller.totalItems.toString(),
                            style: TextStyles.defaultStyle.whiteText,
                          )
                        : const SizedBox(),
                    child: Icon(Icons.shopping_bag_rounded, color: Palettes.p2, size: 30.h),
                  ),
                )
              : GestureDetector(
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
  );
}

Widget sliverToBoxAdapterFoodDetail(ProductModel product) {
  return SliverToBoxAdapter(
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10.h),
          child: Text(
            product.name!,
            style: TextStyle(fontSize: 26.sp),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.h),
          child: Text(product.description!),
        ),
      ],
    ),
  );
}
