import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zakat_app/Screens/Message/message.dart';
import 'package:zakat_app/Screens/Profile/profileScreen.dart';
import 'package:zakat_app/Screens/cart/cartScreen.dart';
import 'package:zakat_app/Screens/home_main.dart';
// import 'package:zakat_app/controller/controller.dart';
import 'package:zakat_app/controller/pagetransition.dart';
import 'package:zakat_app/controller/controller.dart';
import 'package:zakat_app/core/app_dummy.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:mainpage/core/AppDummyData.dart';
// import 'package:mainpage/src/Screens/HomeScreen.dart';
// import 'package:mainpage/src/Screens/cartScreen.dart';
// import 'package:mainpage/src/Screens/favoriteScreen.dart';
// import 'package:mainpage/src/Screens/profileScreen.dart';
// import 'package:mainpage/src/controller/controller.dart';
// import 'package:mainpage/src/controller/pagetransition.dart';

final FoodController controller = Get.put(FoodController());

class Navigation extends StatelessWidget {
  Navigation({super.key});

  final List<Widget> screen = [
    // const FoodListScreen(),
    const Home(),
    const Message(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => PageTransition(
          child: screen[controller.currentBottomNavItemIndex.value],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          fixedColor: Colors.black,
          unselectedItemColor: const Color.fromARGB(87, 0, 0, 0),
          backgroundColor: const Color.fromARGB(117, 0, 0, 0),
          currentIndex: controller.currentBottomNavItemIndex.value,
          onTap: controller.switchBetweenBottomNavigationItems,
          selectedFontSize: 10,
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
