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
  static double height5 = screenHeight / (screenHeight / 5);
  static double height10 = screenHeight / (screenHeight / 10);
  static double height15 = screenHeight / (screenHeight / 15);
  static double height20 = screenHeight / (screenHeight / 20);
  static double height30 = screenHeight / (screenHeight / 30);
  static double height45 = screenHeight / (screenHeight / 45);

//dynamic width padding and margin
  static double width10 = screenHeight / (screenHeight / 10);
  static double width15 = screenHeight / (screenHeight / 15);
  static double width20 = screenHeight / (screenHeight / 20);
  static double width30 = screenHeight / (screenHeight / 30);
  static double width45 = screenHeight / (screenHeight / 45);

//dynamic icons size
  static double icon16 = screenHeight / (screenHeight / 16);
  static double icon24 = screenHeight / (screenHeight / 24);

//
  static double font14 = screenHeight / (screenHeight / 14);
  static double font16 = screenHeight / (screenHeight / 16);
  static double font20 = screenHeight / (screenHeight / 20);
  static double font26 = screenHeight / (screenHeight / 26);

//
  static double radius15 = screenHeight / (screenHeight / 15);
  static double radius20 = screenHeight / (screenHeight / 20);
  static double radius30 = screenHeight / (screenHeight / 30);

  //list view size
  static double listViewImages = screenHeight / (screenHeight / 120);
  static double listViewTextConSize = screenHeight / (screenHeight / 100);

  //popular image detail
  static double popularImageDetail = screenHeight / (screenHeight / 400);

  //bottom height
  static double bottomHeight = screenHeight / (screenHeight / 100);

  // splash screen
  static double splashImg = screenHeight / (screenHeight / 250);

  // back ground detail image
  static double backGroundDetailImage = screenHeight / (screenHeight / 280);

  // bottom sheet
  static double bottomSheet = screenHeight / (screenHeight / 120);
    // bottom sheet pop up
  static double bottomSheetPopUp = screenHeight / (screenHeight / 350);
}
