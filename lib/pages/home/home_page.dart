import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../theme/palette.dart';
import '../cart/cart_history.dart';
import 'main_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      const MainHomePage(),
      const Center(child: Text("Search")),
      const CartHistory(),
      const Center(child: Text("Favorite")),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.house_fill),
        title: ("Home"),
        activeColorPrimary: Palette.mainColor,
        inactiveColorPrimary: Palette.yellowColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.square_favorites_alt_fill),
        title: ("Favorite"),
        activeColorPrimary: Palette.mainColor,
        inactiveColorPrimary: Palette.yellowColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart_fill),
        title: ("Cart"),
        activeColorPrimary: Palette.mainColor,
        inactiveColorPrimary: Palette.yellowColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_alt),
        title: ("Me"),
        activeColorPrimary: Palette.mainColor,
        inactiveColorPrimary: Palette.yellowColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
