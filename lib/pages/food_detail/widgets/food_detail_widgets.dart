import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ihun_food_delivery/config/palettes.dart';
import 'package:ihun_food_delivery/controllers/popular_product_controller.dart';
import 'package:ihun_food_delivery/model/product.dart';

Widget bottomSheetFoodToCart(BuildContext context, ProductModel product) {
  return Container(
    decoration: ShapeDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.h),
          topRight: Radius.circular(30.h),
        ),
      ),
      color: Palettes.p1,
    ),
    width: double.maxFinite,
    height: 120.h,
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
                  padding: MaterialStateProperty.all(EdgeInsets.all(20.h)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20.sp))),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return GetBuilder<PopularProductController>(
                        builder: (controller) => SizedBox(
                              height: 350.h,
                              child: Column(
                                children: [
                                  SizedBox(height: 45.h),
                                  Text(
                                    'Adding ${product.name!} to your cart',
                                    style: TextStyle(fontSize: 20.sp),
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
                                                  padding: MaterialStateProperty.all(EdgeInsets.all(20.h)),
                                                  backgroundColor: MaterialStateProperty.all(Palettes.p1)),
                                              child: Text('Add To Cart',
                                                  style: TextStyle(color: Colors.white, fontSize: 20.sp)),
                                              onPressed: () {
                                                controller.addItems(product);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                padding: MaterialStateProperty.all(EdgeInsets.all(20.h)),
                                                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                                              ),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(color: Colors.white, fontSize: 20.sp),
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
                  padding: MaterialStateProperty.all(EdgeInsets.all(20.h)),
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20.sp))),
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
