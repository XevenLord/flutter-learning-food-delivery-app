import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
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
                onTap: (){
                  Get.to(() => MainFoodPage());
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
                return ListView.builder(
                  itemCount: cartController.getItems.length,
                  itemBuilder: (_, index) {
                    return Container(
                      width: double.maxFinite,
                      height: Dimension.height20 * 5,
                      child: Row(
                        children: [
                          Container(
                            width: Dimension.height20 * 5,
                            height: Dimension.height20 * 5,
                            margin: EdgeInsets.only(bottom: Dimension.height10),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + cartController.getItems[index].img!),
                              ),
                              borderRadius:
                                  BorderRadius.circular(Dimension.radius20),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: Dimension.width10),
                              height: Dimension.height20 * 5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: cartController.getItems[index].name!,
                                    color: Colors.black54,
                                  ),
                                  SmallText(text: "Spicy"),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BigText(
                                          text: cartController.getItems[index].price.toString(),
                                          color: Colors.redAccent),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Dimension.height10,
                                            horizontal: Dimension.width10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimension.radius20),
                                            color: Colors.white),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // popularProduct.setQuantity(false);
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                color: AppColors.signColor,
                                              ),
                                            ),
                                            SizedBox(
                                                width: Dimension.width10 / 2),
                                            BigText(text: "0"),
                                            SizedBox(
                                                width: Dimension.width10 / 2),
                                            GestureDetector(
                                                onTap: () {
                                                  // popularProduct
                                                  //     .setQuantity(true);
                                                },
                                                child: Icon(Icons.add,
                                                    color: AppColors.signColor))
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
    ));
  }
}
