import 'package:flutter/material.dart';

import '../custom/dimension.dart';

class NodataPage extends StatelessWidget {
  final String text;
  final String imagePath;
  const NodataPage({Key? key, required this.text, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width * 0.22,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: Dimensions.font16,
            color: Theme.of(context).disabledColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
