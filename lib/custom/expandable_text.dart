import 'package:flutter/material.dart';

import '/custom/dimension.dart';
import '/custom/small_text.dart';
import '/theme/palette.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight / 6.21;
  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(
        textHeight.toInt() + 1,
        widget.text.length,
      );
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              color: Palette.paraColor,
              text: firstHalf,
              size: Dimensions.font16,
            )
          : Column(
              children: [
                SmallText(
                    size: Dimensions.font16,
                    color: Palette.paraColor,
                    text: hiddenText
                        ? ("$firstHalf...")
                        : (firstHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                        text: hiddenText ? "Xem thêm" : "Đóng",
                        color: Palette.mainColor,
                        size: Dimensions.font14,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: Palette.mainColor,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
