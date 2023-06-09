import 'package:flutter/material.dart';

import '/theme/palette.dart';

import 'big_text.dart';
import 'dimension.dart';
import 'icon_text.dart';
import 'small_text.dart';

class AppColumn extends StatelessWidget {
  final String bigText;
  final String smallText1;
  // final String smallText2;
  final int star;
  // final String iconText1;
  // final String iconText2;
  // final String iconText3;

  const AppColumn({
    Key? key,
    required this.bigText,
    required this.smallText1,
    // required this.smallText2,
    required this.star,
    // required this.iconText1,
    // required this.iconText2,
    // required this.iconText3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: bigText,
          size: Dimensions.font26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                star,
                (index) => Icon(
                  Icons.star,
                  color: Palette.mainColor,
                  size: Dimensions.icon16,
                ),
              ),
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(text: "$smallText1.0"),
            SizedBox(
              width: Dimensions.width10,
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconText(
              icon: Icons.circle_sharp,
              text: "High",
              iconColor: Palette.iconColor1,
            ),
            // SizedBox(
            //   width: 30,
            // ),
            IconText(
              icon: Icons.location_on,
              text: "2.3km",
              iconColor: Palette.mainColor,
            ),
            // SizedBox(
            //   width: 30,
            // ),
            IconText(
              icon: Icons.access_time_filled_rounded,
              text: "35min",
              iconColor: Palette.iconColor2,
            ),
          ],
        )
      ],
    );
  }
}
