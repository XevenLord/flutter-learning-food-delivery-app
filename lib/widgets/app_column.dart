import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';

import '../utils/dimension.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: text),
          SizedBox(height: Dimension.height10),
          Row(
            children: [
              Wrap(
                children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor, size: Dimension.height15)),
              ),
              SizedBox(width: Dimension.width10),
              SmallText(text: '4.5'),
              SizedBox(width: Dimension.width10),
              SmallText(text: '1287'),
              SizedBox(width: Dimension.width10),
              SmallText(text: 'comments')
            ],
          ),
          SizedBox(height: Dimension.height20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconAndTextWidget(icon: Icons.circle_sharp, 
                text: 'Normal', 
                iconColor: AppColors.iconColor1
              ),

              IconAndTextWidget(icon: Icons.location_on,
                text: '1.7 km', 
                iconColor: AppColors.mainColor),

              IconAndTextWidget(icon: Icons.access_time_rounded,
                text: '32min', 
                iconColor: AppColors.iconColor1)
            ],
          )
        ]
      ),
    );
  }
}