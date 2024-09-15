import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zakat_app/Screens/All_Category/all_category.dart';
import 'package:zakat_app/Screens/Home/home_main.dart';
import 'package:zakat_app/Screens/Message/message.dart';
import 'package:zakat_app/Screens/Profile/profileScreen.dart';
import 'package:zakat_app/Screens/cart/cartScreen.dart';
// import 'package:zakat_app/Widgets/drawers_main.dart';
import 'package:zakat_app/controller/pagetransition.dart';
import 'package:zakat_app/core/app_dummy.dart';

class Navigation extends StatelessWidget {
  Navigation({super.key});

  final List<Widget> screen = [
    const Home(),
    const Message(),
    const AllCategory(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
        //  drawer: const MainDrawer(),
      body: Obx(
        () => PageTransition(
          child: screen[controller.currentBottomNavItemIndex.value],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          fixedColor: Colors.black,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.black.withOpacity(0.8), // Adjust transparency
          currentIndex: controller.currentBottomNavItemIndex.value,
          onTap: controller.switchBetweenBottomNavigationItems,
          selectedFontSize: 20,
          items: bottomNavigationItems.map(
            (element) {
              return BottomNavigationBarItem(
                icon: element.disableIcon,
                label: element.label,
                activeIcon: element.enableIcon,
              );
            },
          ).toList(),
        );
      }),
    );
  }
}
