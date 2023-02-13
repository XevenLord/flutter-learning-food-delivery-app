import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/extendable_text_widget.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class RecommendedFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  RecommendedFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(page == "cartpage"){
                        Get.toNamed(RouteHelper.getCartPage());
                      } else {
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },
                    child: AppIcon(icon: Icons.clear),
                  ),
                  // AppIcon(icon: Icons.shopping_cart_outlined)
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
                            Get.find<PopularProductController>().totalItems >= 1
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
                            Get.find<PopularProductController>().totalItems >= 1
                                ? Positioned(
                                    right: 3,
                                    top: 3,
                                    child: BigText(
                                      text: Get.find<PopularProductController>()
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
                ],
              ),
              pinned: true,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(
                      child:
                          BigText(size: Dimension.font26, text: product.name!)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimension.radius20),
                        topRight: Radius.circular(Dimension.radius20),
                      )),
                ),
              ),
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              )),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Dimension.width20),
                    child: ExpandableTextWidget(text: product.description!),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimension.height10,
                      horizontal: Dimension.width20 * 2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (() {
                          controller.setQuantity(false);
                        }),
                        child: AppIcon(
                            iconSize: Dimension.iconSize24,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor,
                            icon: Icons.remove),
                      ),
                      BigText(
                        text:
                            "\$ ${product.price!} X  ${controller.inCartItems} ",
                        color: AppColors.mainBlackColor,
                        size: Dimension.font26,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.setQuantity(true);
                        },
                        child: AppIcon(
                            iconSize: Dimension.iconSize24,
                            iconColor: Colors.white,
                            backgroundColor: AppColors.mainColor,
                            icon: Icons.add),
                      ),
                    ],
                  ),
                ),
                Container(
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
                              borderRadius:
                                  BorderRadius.circular(Dimension.radius20),
                              color: Colors.white),
                          child: Icon(
                            Icons.favorite,
                            color: AppColors.mainColor,
                          )),
                      GestureDetector(
                        onTap: () {
                          controller.addItem(product);
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
                            text: "\$ ${product.price!} | Add to cart",
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
