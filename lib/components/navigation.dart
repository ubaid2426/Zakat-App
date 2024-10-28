import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zakat_app/Screens/All_Category/Group/all_category.dart';
import 'package:zakat_app/Screens/All_Category/Individual/all_category.dart';
// import 'package:zakat_app/Screens/All_Category/all_category.dart';
import 'package:zakat_app/Screens/Home/home_main.dart';
// import 'package:zakat_app/Screens/Login/Screen/login_page.dart';
import 'package:zakat_app/Screens/Message/message.dart';
// import 'package:zakat_app/Screens/PopUp/pop_up.dart';
import 'package:zakat_app/Screens/Profile/profileScreen.dart';
import 'package:zakat_app/Screens/cart/cartScreen.dart';

// void main() => runApp(Navigation());

class Navigation extends StatelessWidget {
  // final Function(BuildContext) showFoodDialog;

  const Navigation({super.key});
  @override
  Widget build(BuildContext context) {
    return
        // MaterialApp(
        // debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        const MyHomePage();
    // );
  }
}

class MyHomePage extends StatefulWidget {
  final Function(BuildContext)? showFoodDialog;
  const MyHomePage({
    super.key,
    this.showFoodDialog,
  });

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  void _showLoginDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: double.infinity,
            height: 320,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Donation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Which type of donation are you perform ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                // const Icon(
                //   Icons.login,
                //   size: 100,
                //   color: Colors.green,
                // ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AllCategoryGroup()), // Navigate to the screen
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Group \n Donation'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AllCategoryIndividual()), // Navigate to the screen
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Individual \n Donation'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
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
      // extendBody: true,
      body: screens[_bottomNavIndex], // Display corresponding screen

      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF7fc23a),
          shape: const CircleBorder(),
          onPressed: _showLoginDialog,
          child: const Icon(
            FontAwesomeIcons.handHoldingDollar,
            size: 35,
          ), // Show popup on button press
          // onPressed: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             AllCategory()), // Navigate to the screen
          //   );
          //   // Action for FAB
          // },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        notchMargin: 10,
        borderColor: const Color(0xFF7fc23a),
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? const Color(0xFF7fc23a) : Colors.grey;
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconList[index], size: 24, color: color),
              const SizedBox(height: 4),
              Text(itemLabels[index], style: TextStyle(color: color)),
            ],
          );
        },
        backgroundColor: Colors.black87,
        activeIndex: _bottomNavIndex,
        splashColor: const Color(0xFF7fc23a),
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        hideAnimationController: _hideBottomBarAnimationController,
        shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Color(0xFF7fc23a),
        ),
      ),
    );
  }
}
