import 'dart:ui';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/all_category.dart';
import 'package:sadqahzakat/Screens/All_Category/Individual/all_category.dart';
import 'package:sadqahzakat/Screens/Home/home_main.dart';
import 'package:sadqahzakat/Screens/Message/message.dart';
import 'package:sadqahzakat/Screens/Profile/profileScreen.dart';
import 'package:sadqahzakat/Screens/cart/cartScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> with TickerProviderStateMixin {
  int _bottomNavIndex = 0; // Default index
  bool _isFabVisible = true; // To control FAB visibility
  late TutorialCoachMark tutorialCoachMark;

  final GlobalKey navigationButton = GlobalKey();
  final GlobalKey navigationButton1 = GlobalKey();
  final GlobalKey navigationButton2 = GlobalKey();
  final GlobalKey navigationButton3 = GlobalKey();

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;
  final ScrollController _scrollController = ScrollController();

  // ... (other code remains the same)
  final List<Widget> screens = [
    const Home(),
    const Message(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  final List<IconData> iconList = [
    Icons.home,
    Icons.message,
    Icons.shopping_cart,
    Icons.person,
  ];

  final List<String> itemLabels = [
    'Home',
    'Message',
    'Cart',
    'Profile',
  ];
  void _showLoginDialog() {
    //  _checkAndShowTutorial1();
    showDialog(
      
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // key: navigationButton1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 80, 184, 99), // First color (#33A248)
                  Color.fromARGB(255, 192, 229, 127), // Second color (#B2EA50)
                ],
                begin: Alignment.topRight,
                end: Alignment.topLeft,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title Section
                  const Text(
                    'Donation',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 5.0,
                          color: Colors.black38,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle Section
                  Text(
                    'Which type of donation would you like to perform?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Button Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDonationButton(
                        key1:  navigationButton1,
                        context: context,
                        label: 'Group\nDonation',
                        icon: Icons.group,
                        color: Colors.green.shade700,
                        navigateTo: const AllCategoryGroup(),
                      ),
                      _buildDonationButton(
                        key1:  navigationButton2,
                        context: context,
                        label: 'Individual\nDonation',
                        icon: Icons.person,
                        color: Colors.grey.shade700,
                        navigateTo: const AllCategoryIndividual(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// A reusable method to create styled donation buttons
  Widget _buildDonationButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required Widget navigateTo,
    required Key key1,
  }) {
    return ElevatedButton.icon(
      key: key1,
      // key: navigationButton3,
      onPressed: () {
        
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigateTo),
        );
      },
      icon: Icon(icon, size: 20, color: Colors.white),
      label: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  void initState() {
    _checkAndShowTutorial();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _checkAndShowTutorial();
    // });
    super.initState();
    _bottomNavIndex = 0;
    // Initialize Animation Controllers
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation =
        Tween<double>(begin: 0, end: 1).animate(borderRadiusCurve);

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Start animations after a delay
    Future.delayed(
        const Duration(seconds: 1), () => _fabAnimationController.forward());
    Future.delayed(const Duration(seconds: 1),
        () => _borderRadiusAnimationController.forward());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
bool onScrollNotification(ScrollNotification notification) {
  if (notification is UserScrollNotification && notification.metrics.axis == Axis.vertical) {
    if (notification.direction == ScrollDirection.forward) {
      if (!_isFabVisible) {
        setState(() {
          _isFabVisible = true;
        });

      }
    } else if (notification.direction == ScrollDirection.reverse) {
      if (_isFabVisible) {
        setState(() {
          _isFabVisible = false;
        });
      }
    }
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
  }
  return false;
}

  // bool onScrollNotification(ScrollNotification notification) {
  //   if (notification is UserScrollNotification &&
  //       notification.metrics.axis == Axis.vertical) {
  //     setState(() {
  //       // Hide FAB on scroll up and show on scroll down
  //       _isFabVisible = notification.direction == ScrollDirection.forward;
  //     });

  //     switch (notification.direction) {
  //       case ScrollDirection.forward:
  //         _hideBottomBarAnimationController.reverse();
  //         _fabAnimationController.forward(from: 0);
  //         break;
  //       case ScrollDirection.reverse:
  //         _hideBottomBarAnimationController.forward();
  //         _fabAnimationController.reverse(from: 1);
  //         break;
  //       case ScrollDirection.idle:
  //         break;
  //     }
  //   }
  //   return false;
  // }

  Future<void> _checkAndShowTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isTutorialShown = prefs.getBool('istutorialShown') ?? false;

    if (!isTutorialShown) {
      createTutorial();
      Future.delayed(Duration.zero, () {
        // ignore: use_build_context_synchronously
        tutorialCoachMark.show(context: context);
      });

      // Mark the tutorial as shown
      prefs.setBool('istutorialShown', true);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: ValueKey("Navigation Screen"),
      extendBody: true,
      body: NotificationListener<ScrollNotification>(
        onNotification: onScrollNotification,
        child: screens[_bottomNavIndex], // Show selected screen
      ),
      floatingActionButton: (_bottomNavIndex != 0 &&
              _bottomNavIndex != 1 &&
              _bottomNavIndex != 2 &&
              _bottomNavIndex != 3)
          ? null
          : _isFabVisible // Show FAB only if it's visible
              ? FloatingActionButton(
                  key: navigationButton,
                  backgroundColor: const Color(0xFF7fc23a),
                  shape: const CircleBorder(),
                  onPressed: () {
                    _showLoginDialog();
                    // _checkAndShowTutorial1();
                    _fabAnimationController.reset();
                    _borderRadiusAnimationController.reset();
                    _borderRadiusAnimationController.forward();
                    _fabAnimationController.forward();
                  },
                  child: const Icon(
                    FontAwesomeIcons.handHoldingDollar,
                    size: 30,
                  ),
                )
              : null,
      floatingActionButtonLocation: (_bottomNavIndex != 0 &&
              _bottomNavIndex != 1 &&
              _bottomNavIndex != 2 &&
              _bottomNavIndex != 3)
          ? null
          : (_isFabVisible // Set FAB location only if it's visible
              ? FloatingActionButtonLocation.centerDocked
              : null),
      bottomNavigationBar: (_bottomNavIndex != 0 &&
              _bottomNavIndex != 1 &&
              _bottomNavIndex != 2 &&
              _bottomNavIndex != 3)
          ? null
          : AnimatedBottomNavigationBar.builder(
              itemCount: iconList.length,
              tabBuilder: (int index, bool isActive) {
                final color = isActive ? const Color(0xFF7fc23a) : Colors.grey;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconList[index],
                      size: 24,
                      color: color,
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AutoSizeText(
                        itemLabels[index],
                        maxLines: 1,
                        style: TextStyle(color: color),
                      ),
                    ),
                  ],
                );
              },
              backgroundColor: Colors.black87,
              activeIndex: _bottomNavIndex,
              splashColor: const Color(0xFF7fc23a),
              notchAndCornersAnimation: borderRadiusAnimation,
              splashSpeedInMilliseconds: 300,
              notchSmoothness: NotchSmoothness.defaultEdge,
              gapLocation: GapLocation.center,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              onTap: (index) {
                setState(() {
                  _bottomNavIndex = index;
                  _isFabVisible =
                      index == 0 || index == 1 || index == 2 || index == 3;
                });
              },
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

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: const Color.fromARGB(13, 25, 192, 59),
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        // print(
        // "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip");
        return true;
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        // identify: "Target 2",
        keyTarget: navigationButton,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: Container(
              height: 300,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Two Types of Donation You Perform",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(
                    "1.Group Donation",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Learn how to collaborate with others to maximize impact through collective giving.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          TargetContent(
              align: ContentAlign.top,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "2.Individual Donation",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Discover the ease of making personal contributions to support your chosen cause.",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ))
        ],
        shape: ShapeLightFocus.RRect,
      ),
    );
    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: navigationButton3,
      contents: [
        TargetContent(
            align: ContentAlign.right,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Title lorem ipsum",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
        targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: navigationButton2,
      contents: [
        TargetContent(
            align: ContentAlign.right,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Title lorem ipsum",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ))
      ],
      shape: ShapeLightFocus.RRect,
    ));
    return targets;
  }

}
