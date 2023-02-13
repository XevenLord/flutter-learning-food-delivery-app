// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_delivery/pages/home/food_page_body.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.only(top: Dimension.height45, bottom: Dimension.height15),
              padding: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(text: 'Malaysia', color: AppColors.mainColor),
                      Row(children: [
                        SmallText(text: 'Selangor', color: Colors.black54),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],)
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimension.width45,
                      height: Dimension.height45,
                      child: Icon(Icons.search, color: Colors.white, size: Dimension.iconSize24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.radius15),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(child: SingleChildScrollView(
            child: FoodPageBody(),
          ))
        ],
      ),
    );
  }
}