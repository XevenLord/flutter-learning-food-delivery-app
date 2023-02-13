import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/extendable_text_widget.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../../utils/dimension.dart';
import '../../widgets/app_icon.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                    width: double.maxFinite,
                    height: Dimension.popularFoodImgSize,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(AppConstants.BASE_URL +
                                AppConstants.UPLOAD_URL +
                                product.img!))))),
            Positioned(
              top: Dimension.height45,
              left: Dimension.width20,
              right: Dimension.width20,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.to(() => MainFoodPage());
                        if(page == "cartpage"){
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          print("sohaii");
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios),
                    ),
                    GetBuilder<PopularProductController>(
                      builder: (controller) {
                        return GestureDetector(
                          onTap: () {
                            if (controller.totalItems >= 1)
                              Get.toNamed(RouteHelper.getCartPage());
                          },
                          child: Stack(
                            children: [
                              AppIcon(icon: Icons.shopping_cart_outlined),
                              Get.find<PopularProductController>().totalItems >=
                                      1
                                  ? Positioned(
                                      right: 0,
                                      top: 0,
                                      child: AppIcon(
                                        icon: Icons.circle,
                                        size: 20,
                                        iconColor: Colors.transparent,
                                        backgroundColor: AppColors.mainColor,
                                      ),
                                    )
                                  : Container(),
                              Get.find<PopularProductController>().totalItems >=
                                      1
                                  ? Positioned(
                                      right: 3,
                                      top: 3,
                                      child: BigText(
                                        text:
                                            Get.find<PopularProductController>()
                                                .totalItems
                                                .toString(),
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        );
                      },
                    ),
                  ]),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: Dimension.popularFoodImgSize - 20,
                child: Container(
                  padding: EdgeInsets.only(
                      left: Dimension.width20,
                      right: Dimension.width20,
                      top: Dimension.height20,
                      bottom: Dimension.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimension.radius20),
                        topLeft: Radius.circular(Dimension.radius20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(text: product.name!),
                      SizedBox(
                        height: Dimension.height20,
                      ),
                      BigText(text: "Introduce"),
                      SizedBox(
                        height: Dimension.height20,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                              child: ExpandableTextWidget(
                                  text: product.description!)))
                    ],
                  ),
                )),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProduct) {
            return Container(
              height: Dimension.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimension.height30,
                  bottom: Dimension.height30,
                  left: Dimension.width20,
                  right: Dimension.width20),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimension.radius20 * 2),
                    topRight: Radius.circular(Dimension.radius20 * 2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimension.height20,
                        horizontal: Dimension.width20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius20),
                        color: Colors.white),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          ),
                        ),
                        SizedBox(width: Dimension.width10 / 2),
                        BigText(text: popularProduct.inCartItems.toString()),
                        SizedBox(width: Dimension.width10 / 2),
                        GestureDetector(
                            onTap: () {
                              popularProduct.setQuantity(true);
                            },
                            child: Icon(Icons.add, color: AppColors.signColor))
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      popularProduct.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimension.height20,
                          horizontal: Dimension.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimension.radius20),
                          color: AppColors.mainColor),
                      child: BigText(
                        text: "\$ ${product.price} | Add to cart",
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
