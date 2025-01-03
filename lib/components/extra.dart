
    // }
    // targets.add(
    //   TargetFocus(
    //     // identify: "Target 1",
    //     keyTarget: keyButton5,
    //     color: Colors.purple,
    //     contents: [
    //       TargetContent(
    //         align: ContentAlign.top,
    //         builder: (context, controller) {
    //           return Column(
    //             // mainAxisSize: MainAxisSize.min,
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               const Text(
    //                 "Two Types of Donation You Perform",
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.white,
    //                   fontSize: 20.0,
    //                 ),
    //               ),
    //               const Padding(
    //                 padding: EdgeInsets.only(top: 10.0),
    //                 child: Column(
    //                   children: [
    //                     Text(
    //                       "1.Group Donation",
    //                       style: TextStyle(color: Colors.white),
    //                     ),
    //                     Text(
    //                       "2.Individual Donation",
    //                       style: TextStyle(color: Colors.white),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               ElevatedButton(
    //                 onPressed: () {
    //                   // keyButton1;
    //                   // controller.previous();
    //                 },
    //                 child: const Icon(Icons.chevron_left),
    //               ),
    //             ],
    //           );
    //         },
    //       )
    //     ],
    //     shape: ShapeLightFocus.RRect,
    //     radius: 5,
    //   ),
    // );







//     import 'dart:ui';

// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:sadqahzakat/Screens/All_Category/Group/all_category.dart';
// import 'package:sadqahzakat/Screens/All_Category/Individual/all_category.dart';
// import 'package:sadqahzakat/Screens/Home/home_main.dart';
// import 'package:sadqahzakat/Screens/Message/message.dart';
// import 'package:sadqahzakat/Screens/Profile/profileScreen.dart';
// import 'package:sadqahzakat/Screens/cart/cartScreen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// class Navigation extends StatefulWidget {
//   const Navigation({super.key});

//   @override
//   State<Navigation> createState() => _NavigationState();
// }

// class _NavigationState extends State<Navigation> {
//   @override
//   Widget build(BuildContext context) {
//     return const MyHomePage();
//   }
// }

// class MyHomePage extends StatefulWidget {
//   final Function(BuildContext)? showFoodDialog;
//   const MyHomePage({
//     super.key,
//     this.showFoodDialog,
//   });

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//   late TutorialCoachMark tutorialCoachMark;
//   GlobalKey keyButton = GlobalKey();
//   GlobalKey keyButton1 = GlobalKey();
//   @override
//   void initState() {
//     super.initState();
//     _fabAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );

//     _hideBottomBarAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 200),
//       vsync: this,
//     );
//     // createTutorial();
//     // Future.delayed(Duration.zero, showTutorial);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       // _showLoginDialog();
//     });
//     _checkAndShowTutorial();
//   }

//   Future<void> _checkAndShowTutorial() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     // Fetch the flag; default is false
//     bool isTutorialShown = prefs.getBool('tutorialShown') ?? false;
//     print("Is tutorial already shown? $isTutorialShown");

//     // Only run if the tutorial has NOT been shown
//     if (!isTutorialShown) {
//       createTutorial();
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         tutorialCoachMark.show(context: context);
//       });

//       // Update the flag to prevent re-showing
//       prefs.setBool('tutorialShown', true);
//     }
//   }

//   void _showLoginDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           contentPadding: EdgeInsets.zero,
//           content: Container(
//             width: double.infinity,
//             height: 300,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               gradient: const LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 80, 184, 99), // First color (#33A248)
//                   Color.fromARGB(255, 192, 229, 127), // Second color (#B2EA50)
//                 ],
//                 begin: Alignment.topRight,
//                 end: Alignment.topLeft,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Title Section
//                   const Text(
//                     'Donation',
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       shadows: [
//                         Shadow(
//                           blurRadius: 5.0,
//                           color: Colors.black38,
//                           offset: Offset(2, 2),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   // Subtitle Section
//                   Text(
//                     'Which type of donation would you like to perform?',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white.withOpacity(0.9),
//                     ),
//                   ),
//                   const SizedBox(height: 30),

//                   // Button Section
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildDonationButton(
//                         context: context,
//                         label: 'Group\nDonation',
//                         icon: Icons.group,
//                         color: Colors.green.shade700,
//                         navigateTo: const AllCategoryGroup(),
//                       ),
//                       _buildDonationButton(
//                         context: context,
//                         label: 'Individual\nDonation',
//                         icon: Icons.person,
//                         color: Colors.grey.shade700,
//                         navigateTo: const AllCategoryIndividual(),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// A reusable method to create styled donation buttons
//   Widget _buildDonationButton({
//     required BuildContext context,
//     required String label,
//     required IconData icon,
//     required Color color,
//     required Widget navigateTo,
//   }) {
//     return ElevatedButton.icon(
//       onPressed: () {
//         Navigator.pop(context);
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => navigateTo),
//         );
//       },
//       icon: Icon(icon, size: 20, color: Colors.white),
//       label: Text(
//         label,
//         textAlign: TextAlign.center,
//         style: const TextStyle(fontSize: 14),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//     );
//   }

//   var _bottomNavIndex = 0; // Default index
//   late AnimationController _fabAnimationController;
//   late AnimationController _hideBottomBarAnimationController;

//   final List<IconData> iconList = [
//     Icons.home,
//     Icons.message,
//     Icons.shopping_cart,
//     Icons.person
//   ];

//   final List<Widget> screens = [
//     const Home(),
//     const Message(),
//     const CartScreen(),
//     const ProfileScreen(),
//   ];
//   final List<GlobalKey> navigationKeys = [
//     GlobalKey(),
//     GlobalKey(),
//     GlobalKey(),
//     GlobalKey(),
//   ];

//   final List<String> itemLabels = [
//     'Home',
//     'Message',
//     'Cart',
//     'Profile',
//   ];
//   @override
//   void initState() {
//     super.initState();

//     _fabAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );

//     _hideBottomBarAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 200),
//       vsync: this,
//     );
//   }

//   @override
//   void dispose() {
//     _fabAnimationController.dispose();
//     _hideBottomBarAnimationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // extendBody: true,
//       body: screens[_bottomNavIndex], // Display corresponding screen

//       floatingActionButton: SizedBox(
//         width: 60,
//         height: 60,
//         child: FloatingActionButton(
//           key: keyButton,
//           backgroundColor: const Color(0xFF7fc23a),
//           shape: const CircleBorder(),
//           onPressed: _showLoginDialog,
//           child: const Icon(
//             FontAwesomeIcons.handHoldingDollar,
//             size: 30,
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//       bottomNavigationBar: AnimatedBottomNavigationBar.builder(
//         itemCount: iconList.length,
//         notchMargin: 10,
//         borderColor: const Color(0xFF7fc23a),
//         tabBuilder: (int index, bool isActive) {
//           final color = isActive ? const Color(0xFF7fc23a) : Colors.grey;
//           return Column(
//             key: navigationKeys[index],
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(iconList[index], size: 20, color: color),
//               const SizedBox(height: 4),
//               Text(itemLabels[index], style: TextStyle(color: color)),
//             ],
//           );
//         },
//         backgroundColor: Colors.black87,
//         activeIndex: _bottomNavIndex,
//         splashColor: const Color(0xFF7fc23a),
//         notchSmoothness: NotchSmoothness.softEdge,
//         gapLocation: GapLocation.center,
//         leftCornerRadius: 32,
//         rightCornerRadius: 32,
//         onTap: (index) => setState(() => _bottomNavIndex = index),
//         hideAnimationController: _hideBottomBarAnimationController,
//         shadow: const BoxShadow(
//           offset: Offset(0, 1),
//           blurRadius: 12,
//           spreadRadius: 0.5,
//           color: Color(0xFF7fc23a),
//         ),
//       ),
//     );
//   }

//   void createTutorial() {
//     tutorialCoachMark = TutorialCoachMark(
//       targets: _createTargets(),
//       colorShadow: const Color.fromARGB(255, 80, 183, 57),
//       textSkip: "SKIP",
//       paddingFocus: 10,
//       opacityShadow: 0.5,
//       imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//       onFinish: () {
//         // SharedPreferences prefs = await SharedPreferences.getInstance();
//         // await prefs.setBool('isTutorialShown', true);
//         print("finish");
//         // return true;
//       },
//       onClickTarget: (target) {
//         print('onClickTarget: $target');
//       },
//       onClickTargetWithTapPosition: (target, tapDetails) {
//         print("target: $target");
//         print(
//             "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
//       },
//       onClickOverlay: (target) {
//         print('onClickOverlay: $target');
//       },
//       onSkip: () {
//         print("skip");
//         return true;
//       },
//     );
//   }

//   List<TargetFocus> _createTargets() {
//     List<TargetFocus> targets = [];
//     targets.add(
//       TargetFocus(
//         // identify: "Target 2",
//         keyTarget: keyButton,
//         contents: [
//           TargetContent(
//             align: ContentAlign.top,
//             child: Container(
//               height: 300,
//               child: const Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 // mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Two Types of Donation You Perform",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 20.0,
//                     ),
//                   ),
//                   Text(
//                     "1.Group Donation",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 20.0),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 10.0),
//                     child: Text(
//                       "Learn how to collaborate with others to maximize impact through collective giving.",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           TargetContent(
//               align: ContentAlign.top,
//               child: const Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 // mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "2.Individual Donation",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 20.0),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 10.0),
//                     child: Text(
//                       "Discover the ease of making personal contributions to support your chosen cause.",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )
//                 ],
//               ))
//         ],
//         shape: ShapeLightFocus.RRect,
//       ),
//     );
//     return targets;
//   }
// }

