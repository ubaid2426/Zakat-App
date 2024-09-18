// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:zakat_app/Screens/All_Category/all_category.dart';
// import 'package:zakat_app/Screens/Home/home_main.dart';
// import 'package:zakat_app/Screens/Message/message.dart';
// import 'package:zakat_app/Screens/PopUp/pop_up.dart';
// import 'package:zakat_app/Screens/Profile/profileScreen.dart';
// import 'package:zakat_app/Screens/cart/cartScreen.dart';
// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

// class Navigation extends StatefulWidget {
//   Navigation({super.key});

//   @override
//   State<Navigation> createState() => _NavigationState();
// }

// class _NavigationState extends State<Navigation> {
//   int _bottomNavIndex = 0; // Active index for the bottom navigation

//   // Icons for the bottom bar
//   final List<IconData> iconList = [
//     Icons.settings, // Leftmost icon
//     Icons.settings_brightness,
//     Icons.brightness_6, // Rightmost icons
//     Icons.settings_brightness,
//   ];

//   final List<Widget> screens = [
//     const Home(),
//     const Message(),
//     const CartScreen(),
//     const ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: screens[_bottomNavIndex], // Displaying the selected screen

//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Color.fromARGB(255, 245, 188, 2),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => Pop()), // Navigate to the popup
//           );
//         },
//         child: const Icon(Icons.nightlight_round, color: Colors.black), // Moon icon
//         shape: CircleBorder(), // Ensuring the FAB is circular
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // FAB in the middle

//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(), // For the notch
//         notchMargin: 8.0, // Space between the notch and FAB
//         child: Container(
//           height: 60,
//           decoration: BoxDecoration(
//             color: Colors.black87,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(32),
//               topRight: Radius.circular(32),
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               // First set of icons (left)
//               Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(iconList[0], color: Colors.orange),
//                     onPressed: () {
//                       setState(() => _bottomNavIndex = 0);
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(iconList[1], color: Colors.white),
//                     onPressed: () {
//                       setState(() => _bottomNavIndex = 1);
//                     },
//                   ),
//                 ],
//               ),

//               // Empty space for the FAB
//               const SizedBox(width: 50),

//               // Second set of icons (right)
//               Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(iconList[2], color: Colors.white),
//                     onPressed: () {
//                       setState(() => _bottomNavIndex = 2);
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(iconList[3], color: Colors.white),
//                     onPressed: () {
//                       setState(() => _bottomNavIndex = 3);
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zakat_app/Screens/Home/home_main.dart';
import 'package:zakat_app/Screens/Login/Screen/login_page.dart';
import 'package:zakat_app/Screens/Message/message.dart';
import 'package:zakat_app/Screens/PopUp/pop_up.dart';
import 'package:zakat_app/Screens/Profile/profileScreen.dart';
import 'package:zakat_app/Screens/cart/cartScreen.dart';

void main() => runApp(Navigation());

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  var _bottomNavIndex = 0; // Default index

  late AnimationController _fabAnimationController;
  late AnimationController _hideBottomBarAnimationController;

  final List<IconData> iconList = [
    Icons.home,
    Icons.message,
    Icons.shopping_cart,
    Icons.person
  ];

  final List<Widget> screens = [
    const Home(),
    const Message(),
    const CartScreen(),
    const ProfileScreen(),
  ];
final List<String> itemLabels = [
  'Home',
  'Message',
  'Cart',
  'Profile',
];
  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _hideBottomBarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // appBar: AppBar(
      //   title: Text('Animated Bottom Bar'),
      // ),
      body: screens[_bottomNavIndex], // Display corresponding screen

      floatingActionButton: FloatingActionButton(
        child: Icon( FontAwesomeIcons.handHoldingDollar,),
        onPressed: () {
            Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const showFoodDialog(),
                    ),
                  );
          // Action for FAB
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Color(0xFF29C77B) : Colors.grey;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconList[index], size: 24, color: color),
              const SizedBox(height: 4),
              Text( itemLabels[index], style: TextStyle(color: color)),
            ],
          );
        },
        backgroundColor: Colors.black87,
        activeIndex: _bottomNavIndex,
        splashColor: Color(0xFF29C77B),
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        hideAnimationController: _hideBottomBarAnimationController,
        shadow: BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Color(0xFF29C77B),
        ),
      ),
    );
  }
}
