import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:fc_native_video_thumbnail/fc_native_video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/blood_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/clothes.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/daig_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/donate_quran.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/food_relief.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/marriage_support.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/masjid_const.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/masjid_maintenance.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/meal_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/medical_bed.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/orphan_support.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/other.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/portable_house.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/tree_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/urgent_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/water_cooler.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/wheel_chair.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/widow_family.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/all_category.dart';
import 'package:sadqahzakat/Screens/Islam/islam_main.dart';
import 'package:sadqahzakat/Screens/Login/Screen/login_page.dart';
import 'package:sadqahzakat/Screens/Need%20Support/need_support.dart';
import 'package:sadqahzakat/Screens/Notification/Screen/notification.dart';
import 'package:sadqahzakat/Screens/donation_service.dart';
import 'package:sadqahzakat/Widgets/drawers_main.dart';
import 'package:sadqahzakat/components/custom_button.dart';
import 'package:sadqahzakat/components/help_child.dart';
import 'package:sadqahzakat/components/homeScreen_carousel.dart';
import 'package:sadqahzakat/components/upcoming_project.dart';
import 'package:sadqahzakat/model/all_category.dart';
import 'package:sadqahzakat/model/doantion_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../All_Category/Group/Screen/small_business.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

bool _hasShownLoginDialog = false;

class _HomeState extends State<Home> {
    late TutorialCoachMark tutorialCoachMark;
    GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  GlobalKey keyButton5 = GlobalKey();

    GlobalKey keyBottomNavigation1 = GlobalKey();
  GlobalKey keyBottomNavigation2 = GlobalKey();
  GlobalKey keyBottomNavigation3 = GlobalKey();
  @override
  void initState() {
    super.initState();
        createTutorial();
    Future.delayed(Duration.zero, showTutorial);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLoginDialog();
    });
  }

  void _showLoginDialog() {
    if (!_hasShownLoginDialog) {
      _hasShownLoginDialog = true;
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
              height: 340,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7fc23a),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please log in to take advantage of the wallet and the advanced notifications',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.login,
                    size: 100,
                    color: Color(0xFF7fc23a),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF7fc23a),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Continue'),
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
  }

  // final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 243, 243),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF33A248), // First color (#33A248)
                  Color(0xFFB2EA50), // Second color (#B2EA50)
                ],
                begin: Alignment.topRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
          title: Column(
            children: [
              // const Text("Sadqahzakat"),
              Image.asset(
                'Assests/images/screen1/10001.png', // Replace with your image path
                fit: BoxFit.contain,
                height: 200,
                width: 200, // Adjust the height as per your requirement
              ),
              // const SizedBox(width: 10), // Spacing between image and text
              // You can add a title next to the image
            ],
          ),
        ),
        drawer: const MainDrawer(),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              // MyHomePage(showFoodDialog: showFoodDialog),
              HomeH1(),
              ReelsSection(),
              CarouselHome(),
              // MainCategory(),
              DisplayCategory(),
              // H1Main(),
              // BoxText(),
              SizedBox(
                height: 50,
              ),
              FinalCard(),
              // MarriageSupportH(
              //   h3: "Our Numbers",
              //   h1: 'Rs.100000+',
              //   h2: 'Meal Donations',
              //   fontawesome: FontAwesomeIcons.faceDizzy,
              // ),
              // MarriageSupportH(
              //   h1: 'Rs.400000+',
              //   h2: 'Flood Donations',
              //   fontawesome: FontAwesomeIcons.bolt,
              // ),
              // MarriageSupportH(
              //   h1: 'Rs.200000+',
              //   h2: 'Medical Donations',
              //   fontawesome: FontAwesomeIcons.houseChimneyUser,
              // ),
              // MarriageSupportH(
              //   h1: 'Rs.300000+',
              //   h2: 'Marriage Support',
              //   fontawesome: FontAwesomeIcons.solidHeart,
              // ),
              // SizedBox(
              //   height: 50,
              // ),
              // FoodDonation(),
              UpComingRender(),
              //  MyHomePage(showFoodDialog: showFoodDialog),
              // UpComingProjects(
              //     image: AssetImage("Assests/images/screen1/upcoming1.png")),
              // UpComingMain(image: AssetImage("Assests/images/screen1/upcoming1.png")),
            ],
          ),
        ),
      ),
    );
  }
    void showTutorial() {
    tutorialCoachMark.show(context: context);
  }




  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.red,
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
        print(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
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
        // identify: "keyBottomNavigation1",
        keyTarget: keyBottomNavigation1,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        // identify: "keyBottomNavigation2",
        keyTarget: keyBottomNavigation2,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        // identify: "keyBottomNavigation3",
        keyTarget: keyBottomNavigation3,
        alignSkip: Alignment.topRight,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      tutorialCoachMark.goTo(0);
                    },
                    child: const Text('Go to index 0'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: keyButton1,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
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
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: keyButton,
        color: Colors.purple,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.previous();
                    },
                    child: const Icon(Icons.chevron_left),
                  ),
                ],
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 2",
        keyTarget: keyButton4,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Multiples content",
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
            ),
          ),
          TargetContent(
              align: ContentAlign.top,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Multiples content",
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
      ),
    );
    targets.add(TargetFocus(
      identify: "Target 3",
      keyTarget: keyButton5,
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
      identify: "Target 4",
      keyTarget: keyButton3,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  tutorialCoachMark.previous();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
                    "https://juststickers.in/wp-content/uploads/2019/01/flutter.png",
                    height: 200,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Image Load network",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
      shape: ShapeLightFocus.Circle,
    ));
    targets.add(
      TargetFocus(
        identify: "Target 5",
        keyTarget: keyButton2,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Multiples contents",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "Multiples contents",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ))
        ],
      ),
    );

    return targets;
  }
}

// class MainCategory extends StatelessWidget {
//   const MainCategory({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "All categories",
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF7fc23a)),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   "see more",
//                   style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     // color: Colors.black,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(
//           width: double.infinity,
//           height: 600,
//           // color: Colors.pink,
//           child: Category(),
//         ),
//       ],
//     );
//   }
// }

class UpComingRender extends StatelessWidget {
  const UpComingRender({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Our UpComing Projects",
          style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w900,
              //  decoration: TextDecoration.underline,
              fontFamily: "Roboto"),
        ),
        SizedBox(
          width: 300,
          child: Divider(
            thickness: 5,
            color: Color(0xFF29C77B),
            height: 30,
          ),
        ),
        UpComingProjects(
          image: AssetImage("Assests/images/screen1/upcoming3.png"),
          text1: 'SEPT',
          text2: '02',
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(25, 15, 25, 25),
          child: Text(
            "Your Donation can help provide food to people",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                fontFamily: "Roboto"),
          ),
        ),
        UpComingProjects(
          image: AssetImage("Assests/images/screen1/upcoming2.png"),
          text1: 'OCT',
          text2: '20',
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(25, 15, 25, 25),
          child: Text(
            "The shop makes donation for conjure EarthQuake. ",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                fontFamily: "Roboto"),
          ),
        ),
        UpComingProjects(
          image: AssetImage("Assests/images/screen1/upcoming1.png"),
          text1: 'Nov',
          text2: '16',
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(25, 15, 25, 25),
          child: Text(
            "Your Donation can help provide food to people",
            style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                fontFamily: "Roboto"),
          ),
        ),
      ],
    );
  }
}

class UpComingProjects extends StatelessWidget {
  const UpComingProjects(
      {super.key,
      required this.image,
      required this.text1,
      required this.text2});
  final ImageProvider image;
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Scaffold(
        home: SafeArea(
          child: InkWell(
            // onTap: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => const AllCategory()));
            // },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Stack(
                  children: [
                    UpComingMain(image: image),
                    Positioned(
                      top: 0,
                      right: 10,
                      width: 100,
                      height: 100,
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              'Assests/svg/button.svg',
                              width: 100,
                              height: 90,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    text1,
                                    style: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        // height: 1.0,
                                        fontWeight: FontWeight.w300),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    text2,
                                    style: const TextStyle(
                                        fontSize: 28,
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class BoxText extends StatelessWidget {
  const BoxText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HelpChild(image: AssetImage("Assests/images/screen1/poverty3.png")),
        HelpText(text: "Help children Rise out of the poverty"),
        HelpChild(image: AssetImage("Assests/images/screen1/poverty4.png")),
        HelpText(text: "Little help that gooes a long way"),
      ],
    );
  }
}

class HelpText extends StatelessWidget {
  const HelpText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CarouselHome extends StatelessWidget {
  const CarouselHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        // color: Colors.red,
        child: const HomePageCarousel(
          imageList: [
            "Assests/images/screen1/10007.png",
            "Assests/images/screen1/10008.png",
            "Assests/images/screen1/10009.png",
            "Assests/images/screen1/10010.png",
            "Assests/images/screen1/10011.png",
          ],
          carouselHeight: 200,
        ),
      ),
    );
  }
}

class HomeH1 extends StatelessWidget {
  const HomeH1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        HomeH2(),
        Positioned(
          right: 25,
          bottom: 20,
          child: HomeH3(),
        ),
      ],
    );
  }
}

class HomeH2 extends StatelessWidget {
  const HomeH2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Column(
        children: [
          Container(
            height: 160,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF33A248), // First color (#33A248)
                  Color(0xFFB2EA50), // Second color (#B2EA50)
                ],
                begin: Alignment.bottomRight, // Start at bottom-right
                end: Alignment.topLeft, // End at top-left
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.20,
                        child: const SizedBox(
                          width: 70,
                          height: 70,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              image: DecorationImage(
                                // scale: 6,
                                image: AssetImage(
                                    'Assests/images/screen1/profile_pic.png'), // Adjust the image path
                                fit: BoxFit.contain, // Adjust the fit as needed
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.60 - 20,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Aslam O Alaikum, Ubaid',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            // SizedBox(height: 10),
                            Text(
                              'Is your zakat payment up to date?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.20,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // Black border color
                              width: 2.0, // Border width
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationMain()));
                            },
                            icon: const Icon(
                              FontAwesomeIcons.bell,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeH3 extends StatefulWidget {
  const HomeH3({super.key});

  @override
  State<HomeH3> createState() => _HomeH3State();
}

class _HomeH3State extends State<HomeH3> {
    late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyButton = GlobalKey();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();

  @override
  void initState() {
    // createTutorial();
    _checkAndShowTutorial();
    // Future.delayed(Duration.zero, showTutorial);
    super.initState();
  }
    Future<void> _checkAndShowTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isTutorialShown = prefs.getBool('tutorialShown') ?? false;

    if (!isTutorialShown) {
      createTutorial();
      Future.delayed(Duration.zero, () {
        tutorialCoachMark.show(context: context);
      });

      // Mark the tutorial as shown
      prefs.setBool('tutorialShown', true);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        // color: Colors.red,
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ButtonNavBar(
            //   text: 'Zakat\nCalculator',
            //   fontawesome: FontAwesomeIcons.bell,
            //   navigateTo: ZakatCalculator(),
            // ),
            ButtonNavBar(
              key: keyButton,
              text: 'Islam',
              fontawesome: FontAwesomeIcons.mosque,
              navigateTo: IslamScreen(),
            ),
            ButtonNavBar(
              key: keyButton1,
              text: 'Need Support',
              fontawesome: FontAwesomeIcons.handshake,
              navigateTo: NeedCategoryGrid(),
            ),
            // ButtonNavBar(
            //   text: 'History',
            //   fontawesome: FontAwesomeIcons.rotateLeft,
            //   navigateTo: DonationHistory(),
            // ),
            ButtonNavBar(
              key: keyButton2,
              text: 'Urgent Donation',
              fontawesome: FontAwesomeIcons.rotateLeft,
              navigateTo: UrgentDonation(),
            ),
          ],
        ),
      ),
    );
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: const Color.fromARGB(255, 73, 174, 45),
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
        print(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
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
        identify: "Target 0",
        keyTarget: keyButton,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Islam Page",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Access Quran, Hadith, prayer times, Qibla direction, and more to enrich your faith journey.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
      targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: keyButton1,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Need Support",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "If you need any kind of help, let us know—we're here for you.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
      targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: keyButton2,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Urgent Donation",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Discover and support critical donation requests immediately.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

        return targets;
  }
}

class ButtonNavBar extends StatelessWidget {
  const ButtonNavBar(
      {super.key,
      required this.text,
      required this.fontawesome,
      required this.navigateTo});
  final String text;
  final IconData fontawesome;
  final Widget navigateTo; // The screen to navigate to
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => navigateTo), // Navigate to the screen
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    // color: const Color.fromARGB(255, 240, 4, 4).withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Icon(fontawesome),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';

// / Reels Section: Displays a list of videos with thumbnails.
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:fc_native_video_thumbnail/fc_native_video_thumbnail.dart';

class ReelsSection extends StatefulWidget {
  const ReelsSection({Key? key}) : super(key: key);

  @override
  _ReelsSectionState createState() => _ReelsSectionState();
}

class _ReelsSectionState extends State<ReelsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Map<String, dynamic>> videoData = [];
  List<String?> thumbnails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    fetchVideos();
  }

  /// Fetch videos from the API
  Future<void> fetchVideos() async {
    const String apiUrl =
        'http://127.0.0.1:8000/data/videos/'; // Replace with your API endpoint
    try {
      final response = await Dio().get(apiUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        setState(() {
          videoData = data
              .map((item) => {
                    'url': item['video'], // Video URL from API
                    'title': item['title'], // Title from API
                  })
              .toList();
        });
        await _generateThumbnails();
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      print("Error fetching videos: $e");
      setState(() => isLoading = false);
    }
  }

  /// Generate thumbnails for videos
  Future<void> _generateThumbnails() async {
    List<String?> tempThumbnails = [];
    for (var video in videoData) {
      try {
        final String videoUrl = video['url'];
        print("http://127.0.0.1:8000${videoUrl}");
        final thumbnail = await generateThumbnailFromNetwork(
            "http://127.0.0.1:8000${videoUrl}");
        tempThumbnails.add(thumbnail);
      } catch (e) {
        print("Error generating thumbnail for ${video['url']}: $e");
        tempThumbnails.add(null);
      }
    }
    setState(() {
      thumbnails = tempThumbnails;
      isLoading = false;
    });
  }

  /// Download video and generate a thumbnail
Future<String?> generateThumbnailFromNetwork(String videoUrl) async {
  try {
    // Download the video file to a temporary location
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/${videoUrl.split('/').last}';
    await Dio().download(videoUrl, filePath);

    // Generate thumbnail using fc_native_video_thumbnail
    final destFile = '${tempDir.path}/thumbnail_${videoUrl.split('/').last}.jpg';
    final plugin = FcNativeVideoThumbnail();
    final thumbnailGenerated = await plugin.getVideoThumbnail(
      srcFile: filePath,
      destFile: destFile,
      width: 300,
      height: 300,
      quality: 75,
    );

    if (thumbnailGenerated) {
      return destFile;
    } else {
      print("Thumbnail generation failed.");
      return null;
    }
  } catch (e) {
    print("Error downloading or generating thumbnail: $e");
    return null;
  }
}


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getAnimatedBorderColor() {
    return ColorTween(
          begin: const Color(0xFF33A248),
          end: const Color(0xFFB2EA50),
        ).evaluate(_controller) ??
        Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Reels Section",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7fc23a)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See More",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: videoData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ReelsPage(videoUrl: videoData[index]['url']),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: [
                            AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                return Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: getAnimatedBorderColor(),
                                        width: 3.0),
                                    borderRadius: BorderRadius.circular(100.0),
                                    image: thumbnails.length > index &&
                                            thumbnails[index] != null
                                        ? DecorationImage(
                                            image: FileImage(
                                                File(thumbnails[index]!)),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 5),
                            Text(
                              videoData[index]['title'],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}

/// Reels Page: Plays the selected video
class ReelsPage extends StatelessWidget {
  final String videoUrl;

  const ReelsPage({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF33A248), Color(0xFFB2EA50)],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ReelVideoPlayer(videoUrl: videoUrl),
      ),
    );
  }
}

/// Reel Video Player
class ReelVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ReelVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _ReelVideoPlayerState createState() => _ReelVideoPlayerState();
}

class _ReelVideoPlayerState extends State<ReelVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    // final videoUrl = "http://127.0.0.1:8000${widget.videoUrl}";
    // Use VideoPlayerController.network instead of networkUrl
    _controller = VideoPlayerController.networkUrl(
      Uri.parse("http://127.0.0.1:8000${widget.videoUrl}"),
    )..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      }).catchError((error) {
        print("Error initializing video: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("http://127.0.0.1:8000${widget.videoUrl}");
    return Center(
      child: _controller.value.isInitialized
          ? GestureDetector(
              onTap: _togglePlayPause,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  if (!_isPlaying)
                    const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 80.0,
                    ),
                ],
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}

// LeftToRight widget to receive a list of filtered projects
class LeftToRight extends StatelessWidget {
  final Widget navigate;
  final List<DonationModel> projects;

  const LeftToRight({
    super.key,
    required this.projects,
    required this.navigate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        // Map the list of projects to PerCategory widgets
        children: projects.map((project) {
          return PerCategory(
            projectValue: project.projectValue,
            paidValue: project.paidValue,
            title: project.title,
            imageUrl: project.imageUrl,
            description: project.description,
            navigate: navigate,
          );
        }).toList(),
      ),
    );
  }
}

// PerCategory widget to display project details
class PerCategory extends StatefulWidget {
  final double? projectValue;
  final double? paidValue;
  final String title;
  final String imageUrl;
  final String description;
  final Widget navigate;

  const PerCategory({
    super.key,
    required this.projectValue,
    required this.paidValue,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.navigate,
  });

  @override
  State<PerCategory> createState() => _PerCategoryState();
}

class _PerCategoryState extends State<PerCategory> {
  @override
  Widget build(BuildContext context) {
    return Material(
      //  color: const Color.fromARGB(255, 209, 206, 206),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.7, // Adjust width
            height: 600,
            child: Column(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 22,
                    decoration: TextDecoration.none,
                    fontFamily: "Roboto",
                    color: Color(0xFF7fc23a),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Divider(
                  color: Color(0xFF7fc23a),
                  thickness: 4,
                  indent: 50,
                  endIndent: 50,
                ), // Add dynamic title
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                          "http://127.0.0.1:8000/data${widget.imageUrl}"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                buildProjectDetails(),
                const SizedBox(
                  height: 10,
                ),
                buildProgressIndicator(),
                const SizedBox(height: 10),
                CustomButton(
                  navigateTo: widget.navigate,
                  title: 'View Category',
                  icon: FontAwesomeIcons.rightFromBracket,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProjectDetails() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 237, 228, 228),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildProjectInfo(
              'Rs ${widget.projectValue!.toInt()}', 'Project Value'),
          buildProjectInfo('${widget.paidValue!.toInt()}', 'Paid'),
          buildProjectInfo(
            'Rs ${(widget.projectValue! - widget.paidValue!).toInt()}',
            'Remaining',
          ),
        ],
      ),
    );
  }

  Widget buildProjectInfo(String value, String label) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 237, 228, 228),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 128, 126, 126),
                fontFamily: "Montserrat",
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgressIndicator() {
    double progress = widget.paidValue! / widget.projectValue!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF7fc23a)),
            minHeight: 10,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${(progress * 100).toInt()}%',
          style: const TextStyle(
            fontSize: 16,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

// FinalCard widget in HomePage
class FinalCard extends StatefulWidget {
  const FinalCard({super.key});

  @override
  State<FinalCard> createState() => _FinalCardState();
}

class _FinalCardState extends State<FinalCard> {
  late Future<List<DonationModel>> sortedClothes;

  @override
  void initState() {
    super.initState();
    sortedClothes = _fetchSortedClothes();
  }

  Future<List<DonationModel>> _fetchSortedClothes() async {
    return await DonationService().fetchDonations(
      filter: "unfinished",
      category: "",
      sort: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "All categories Card",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7fc23a)),
          ),
        ),
        FutureBuilder<List<DonationModel>>(
          future: sortedClothes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text("Error loading data");
            } else {
              final projects = snapshot.data ?? [];
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "clothes")
                          .toList(),
                      navigate: const Clothes(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "portablehouse")
                          .toList(),
                      navigate: const PortableHouse(),
                    ),
                    LeftToRight(
                      projects:
                          projects.where((p) => p.category == "blood").toList(),
                      navigate: const Blood(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "donatequran")
                          .toList(),
                      navigate: const DonateQuran(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "	SmallBusinessSetup")
                          .toList(),
                      navigate: const 
                      SmallBusiness(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "masjidConst")
                          .toList(),
                      navigate: const MasjidConst(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "	waterCooler")
                          .toList(),
                      navigate: const WaterCooler(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "orphansupport")
                          .toList(),
                      navigate: const OrphanSupport(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "mealdonation")
                          .toList(),
                      navigate: const MealDonation(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "daigdonation")
                          .toList(),
                      navigate: const DaigDonation(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "treedonation")
                          .toList(),
                      navigate: const TreeDonation(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "wheelchair")
                          .toList(),
                      navigate: const WheelChair(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "medicalbed")
                          .toList(),
                      navigate: const MedicalBed(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "widowfamily")
                          .toList(),
                      navigate: const WidowFamily(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "floodrelief")
                          .toList(),
                      navigate: const FloodRelief(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "marriagesupport")
                          .toList(),
                      navigate: const MarriageSupport(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "masjidmaintenance")
                          .toList(),
                      navigate: const MasjidMaintenance(),
                    ),
                    LeftToRight(
                      projects: projects
                          .where((p) => p.category == "	other")
                          .toList(),
                      navigate: const Other(),
                    ),
                    // Add more categories as needed
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class DisplayCategory extends StatelessWidget {
  const DisplayCategory({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double height = (screenWidth < 400) ? 1300 : 1100;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Select Category",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7fc23a)),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "see more -->",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          // color: Colors.black,
          height: height,
          child: const CategoryGrid(),
        ),
      ],
    );
  }
}

class CategoryGrid extends StatefulWidget {
  const CategoryGrid({super.key});

  @override
  _CategoryGridState createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  late Future<List<AllCategoryModel>> categories;

  @override
  void initState() {
    super.initState();
    categories = fetchCategories();
  }

  // Fetch categories from API
  Future<List<AllCategoryModel>> fetchCategories() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/data/categories/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => AllCategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Route mapping function
  Widget getRouteWidget(String route) {
    switch (route) {
      case '/MasjidMaintenance':
        return const MasjidMaintenance();
      case '/Clothes':
        return const Clothes();
      case '/PortableHouse':
        return const PortableHouse();
      case '/MarriageSupport':
        return const MarriageSupport();
      case '/FloodRelief':
        return const FloodRelief();
      case '/OrphanSupport':
        return const OrphanSupport();
      case '/Other':
        return const Other();
      case '/TreeDonation':
        return const TreeDonation();
      case '/WaterCooler':
        return const WaterCooler();
      case '/SmallBusinessSetup':
        return const SmallBusiness();
      case '/MealDonation':
        return const MealDonation();
      case '/DaigDonation':
        return const DaigDonation();
      case '/WidowFamily':
        return const WidowFamily();
      case '/MedicalBed':
        return const MedicalBed();
      case '/WheelChair':
        return const WheelChair();
      case '/MasjidConst':
        return const MasjidConst();
      case '/DonateQuran':
        return const DonateQuran();
      case '/Blood':
        return const Blood();
      default:
        print('Unknown route tapped: $route');
        return const Center(
          child: Text('Page not found'),
        ); // or replace with a custom error widget
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth < 600)
        ? 3
        : (screenWidth < 900)
            ? 4
            : 5;
    double childAspectRatio = (screenWidth < 400) ? 2 / 3.5 : 3 / 4;

    return FutureBuilder<List<AllCategoryModel>>(
      future: categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Failed to load categories'));
        }

        final categoryList = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              final category = categoryList[index];
              return CategoryTile(
                category: category,
                onSelectCategory: () {
                  print("Navigating to: ${category.route}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => getRouteWidget(category.route),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
