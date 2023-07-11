import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ihun_food_delivery/config/palettes.dart';

import 'config/components.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  int navDrawerIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageWidget[navDrawerIndex],
      bottomNavigationBar: NavigationBar(
        height: 50.h,
        backgroundColor: Palettes.p4,
        indicatorColor: Palettes.textWhite,
        animationDuration: const Duration(milliseconds: 200),
        surfaceTintColor: Palettes.p5,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (selectedIndex) {
          setState(() {
            navDrawerIndex = selectedIndex;
          });
        },
        selectedIndex: navDrawerIndex,
        destinations: appBarDestinations,
      ),
    );
  }
}
