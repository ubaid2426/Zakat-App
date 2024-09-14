
import 'package:flutter/material.dart';
import 'package:zakat_app/core/app_icons.dart';
import 'package:zakat_app/model/buttom-nevigation-item.dart';

List<BottomNavigationItem> bottomNavigationItems = [
  BottomNavigationItem(
    const Icon(Icons.home_outlined),
    const Icon(Icons.home),
    'Home',
    isSelected: true,
  ),
  BottomNavigationItem(
    const Icon(Icons.shopping_cart_outlined),
    const Icon(Icons.shopping_cart),
    'Shopping cart',
  ),
  BottomNavigationItem(
    const Icon(AppIcon.outlinedHeart),
    const Icon(AppIcon.heart),
    'Favorite',
  ),
  BottomNavigationItem(
    const Icon(Icons.person_outline),
    const Icon(Icons.person),
    'Profile',
  )
];