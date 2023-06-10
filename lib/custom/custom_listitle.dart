import 'package:flutter/material.dart';
import 'package:ihun_food_delivery/custom/dimension.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.location,
    required this.price,
  });

  final Widget thumbnail;
  final String title;
  final String location;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: thumbnail,
            ),
            SizedBox(
              width: Dimensions.height10,
            ),
            Expanded(
              flex: 3,
              child: _VideoDescription(
                title: title,
                location: location,
                price: price,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoDescription extends StatelessWidget {
  const _VideoDescription({
    required this.title,
    required this.location,
    required this.price,
  });

  final String title;
  final String location;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            location,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$price\$',
          ),
        ],
      ),
    );
  }
}
