import 'package:get/get.dart';

class Dimension {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenWidth / 7.03;

  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;

  // Dynamic width padding and margin
  static double width10 = screenHeight / 84.4;
  static double width15 = screenHeight / 56.27;
  static double width20 = screenHeight / 42.2;
  static double width30 = screenHeight / 28.13;
  static double width45 = screenHeight / 18.76;

  // font
  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.46;

  // radius
  static double radius15 = screenHeight / 56.27;
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;

  // icon size
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;
  static double icom30 = screenHeight / 28.13;

  // list view size
  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextContSize = screenWidth / 3.9;

  // popular size
  static double popularFoodImgSize = screenHeight / 2.43;

  // bottom height
  static double buttonHeightBar = screenHeight / 7.03;

  // splash screen dimension
  static double splashImg = screenHeight / 3.38;
}
