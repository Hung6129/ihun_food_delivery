import 'package:flutter/material.dart';

import '/custom/dimension.dart';
import '/custom/small_text.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final Color textColor;
  const IconText({
    Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: Dimensions.icon24,
          color: iconColor,
        ),
        const SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
          color: textColor,
        ),
      ],
    );
  }
}
