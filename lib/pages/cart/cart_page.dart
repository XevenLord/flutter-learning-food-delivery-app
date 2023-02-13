import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: Dimension.height20 * 3,
              left: Dimension.width20,
              right: Dimension.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimension.iconSize24,
                  ),
                  SizedBox(width: Dimension.width20 * 5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimension.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimension.iconSize24,
                  ),
                ],
              ),
            ),
            Positioned(
              top: Dimension.height20 * 5,
              left: Dimension.width20,
              right: Dimension.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimension.height15),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController) {
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                      itemCount: _cartList.length,
                      itemBuilder: (_, index) {
                        return Container(
                          width: double.maxFinite,
                          height: Dimension.height20 * 5,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  var popularIndex =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(_cartList[index].product!);
                                  if (popularIndex >= 0) {
                                    Get.toNamed(RouteHelper.getPopularFood(
                                        popularIndex, "cartpage"));
                                  } else {
                                    var recommendedIndex =
                                        Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product!);

                                    Get.toNamed(RouteHelper.getRecommendedFood(
                                        recommendedIndex, "cartpage"));
                                  }
                                },
                                child: Container(
                                  width: Dimension.height20 * 5,
                                  height: Dimension.height20 * 5,
                                  margin: EdgeInsets.only(
                                      bottom: Dimension.height10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(AppConstants
                                              .BASE_URL +
                                          AppConstants.UPLOAD_URL +
                                          cartController.getItems[index].img!),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        Dimension.radius20),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(left: Dimension.width10),
                                  height: Dimension.height20 * 5,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                        text: _cartList[index].name!,
                                        color: Colors.black54,
                                      ),
                                      SmallText(text: "Spicy"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                              text: cartController
                                                  .getItems[index].price
                                                  .toString(),
                                              color: Colors.redAccent),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: Dimension.height10,
                                                horizontal: Dimension.width10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimension.radius20),
                                                color: Colors.white),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    cartController.addItem(
                                                        _cartList[index]
                                                            .product!,
                                                        -1);
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: AppColors.signColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width:
                                                        Dimension.width10 / 2),
                                                BigText(
                                                    text: _cartList[index]
                                                        .quantity
                                                        .toString()),
                                                SizedBox(
                                                    width:
                                                        Dimension.width10 / 2),
                                                GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          _cartList[index]
                                                              .product!,
                                                          1);
                                                    },
                                                    child: Icon(Icons.add,
                                                        color: AppColors
                                                            .signColor))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
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
                        SizedBox(width: Dimension.width10 / 2),
                        BigText(text: "\$ " + cartController.totalAmount.toString()),
                        SizedBox(width: Dimension.width10 / 2),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // popularProduct.addItem(product);
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
                        text: "Check Out",
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
