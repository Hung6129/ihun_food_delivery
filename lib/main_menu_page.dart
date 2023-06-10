import 'package:flutter/material.dart';
import 'package:ihun_food_delivery/base/components.dart';

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
