import 'package:get/get.dart';

class Dimension{
  // screen height 802.909
  // screen width 392.727
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;


  static double pageView = screenHeight/2.51;
  static double pageViewContainer = screenHeight/3.65;
  static double pageViewTextContainer = screenHeight/6.69;
  // dynamic height padding and margin
  static double height10 = screenHeight/80.3909;
  static double height15 = screenHeight/53.53;
  static double height20 = screenHeight/40.145;
  static double height30 = screenHeight/26.76;
  static double height45 = screenHeight/17.84;
  
  // dynamic width padding and margin
  static double width5 = screenWidth/78.54;
  static double width10 = screenWidth/39.2727;
  static double width15 = screenWidth/26.1818;
  static double width20 = screenWidth/19.636;
  static double width30 = screenWidth/13.09;
  static double width45 = screenWidth/8.727;

  // font size
  static double font16 = screenHeight/50.182;
  static double font20 = screenHeight/40.145;
  static double font26 = screenHeight/30.881;

  static double radius15 = screenHeight/53.53;
  static double radius20 = screenHeight/40.145;
  static double radius30 = screenHeight/26.76;

  // icon Size
  static double iconSize24 = screenHeight/33.454;
  static double iconSize16 = screenHeight/50.182;

  // list view size
  static double listViewImgSize = screenWidth/3.27;
  static double listViewTextContSize = screenWidth/3.927;

  // popular food
  static double popularFoodImgSize = screenHeight/2.294;

  // bottom height
  static double bottomHeightBar = screenHeight/6.69;

  // splash screen dimensions
  static double splashImg = screenHeight/3.38;
}