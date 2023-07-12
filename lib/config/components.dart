import 'package:flutter/material.dart';
import 'package:ihun_food_delivery/config/palettes.dart';
import 'package:ihun_food_delivery/views/cart/cart_history.dart';
import 'package:ihun_food_delivery/views/home/home_page.dart';
import 'package:ihun_food_delivery/views/profile/user_profile_page.dart';

const List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
      tooltip: '',
      icon: Icon(
        Icons.home_outlined,
        color: Palettes.p1,
      ),
      label: 'Home',
      selectedIcon: Icon(
        Icons.home,
        color: Palettes.p1,
      )),
  NavigationDestination(
    tooltip: '',
    icon: Icon(
      Icons.shopping_bag_outlined,
      color: Palettes.p1,
    ),
    label: 'Cart',
    selectedIcon: Icon(
      Icons.shopping_bag,
      color: Palettes.p1,
    ),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(
      Icons.person_2_outlined,
      color: Palettes.p1,
    ),
    label: 'Profile',
    selectedIcon: Icon(
      Icons.person,
      color: Palettes.p1,
    ),
  ),
];

const pageWidget = [
  HomePage(),
  CartHistory(),
  UserProfilePage(),
];
