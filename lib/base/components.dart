import 'package:flutter/material.dart';
import 'package:ihun_food_delivery/pages/cart/cart_history.dart';
import 'package:ihun_food_delivery/pages/home/home_page.dart';
import 'package:ihun_food_delivery/pages/profile/user_profile_page.dart';

const List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.home_outlined),
    label: 'Home',
    selectedIcon: Icon(Icons.home),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.shopping_bag_outlined),
    label: 'Cart',
    selectedIcon: Icon(Icons.shopping_bag),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.person_2_outlined),
    label: 'Profile',
    selectedIcon: Icon(Icons.person),
  ),
  // NavigationDestination(
  //   tooltip: '',
  //   icon: Icon(Icons.invert_colors_on_outlined),
  //   label: 'Elevation',
  //   selectedIcon: Icon(Icons.opacity),
  // )
];

const pageWidget = [
  HomePage(),
  CartHistory(),
  UserProfilePage(),
];
