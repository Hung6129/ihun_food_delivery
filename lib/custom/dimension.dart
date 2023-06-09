import 'package:get/get.dart';

class Dimensions {
//
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

//
  static double pageView = screenHeight / 2.13;
  static double pageViewContainer = screenHeight / 3.1;
  static double pageViewTextContainer = screenHeight / 5.7;

//dynamic height padding and margin
  static double height5 = screenHeight / (683 / 5);
  static double height10 = screenHeight / (683 / 10);
  static double height15 = screenHeight / (683 / 15);
  static double height20 = screenHeight / (683 / 20);
  static double height30 = screenHeight / (683 / 30);
  static double height45 = screenHeight / (683 / 45);

//dynamic width padding and margin
  static double width10 = screenHeight / (683 / 10);
  static double width15 = screenHeight / (683 / 15);
  static double width20 = screenHeight / (683 / 20);
  static double width30 = screenHeight / (683 / 30);
  static double width45 = screenHeight / (683 / 45);

//dynamic icons size
  static double icon16 = screenHeight / (683 / 16);
  static double icon24 = screenHeight / (683 / 24);

//
  static double font14 = screenHeight / (683 / 14);
  static double font16 = screenHeight / (683 / 16);
  static double font20 = screenHeight / (683 / 20);
  static double font26 = screenHeight / (683 / 26);

//
  static double radius15 = screenHeight / (683 / 15);
  static double radius20 = screenHeight / (683 / 20);
  static double radius30 = screenHeight / (683 / 30);

  //list view size
  static double listViewImages = screenHeight / (683 / 120);
  static double listViewTextConSize = screenHeight / (683 / 100);

  //popular image detail
  static double popularImageDetail = screenHeight / (683 / 300);

  //bottom height
  static double bottomHeight = screenHeight / (683 / 100);

  // splash screen
  static double splashImg = screenHeight / (683 / 250);
}
