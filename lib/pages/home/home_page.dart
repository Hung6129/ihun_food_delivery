import 'package:flutter/material.dart';
import 'package:ihun_food_delivery/pages/home/widgets/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const SingleChildScrollView(
          child: Column(
            children: [PopularFoods(), RecommendedFoods()],
          ),
        ));
  }
}
