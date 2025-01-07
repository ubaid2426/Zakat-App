import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:fc_native_video_thumbnail/fc_native_video_thumbnail.dart';
// import 'package:fc_native_video_thumbnail/fc_native_video_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/blood_donation/blood_main.dart';
// import 'package:sadqahzakat/Screens/All_Category/Group/Screen/blood_donation/blood_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/clothes.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/daig_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/donate_quran.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/food_relief.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/gaza.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/marriage_support.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/masjid_const.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/masjid_maintenance.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/meal_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/medical_bed.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/orphan_support.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/other.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/portable_house.dart';
// import 'package:sadqahzakat/Screens/All_Category/Group/Screen/tree_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/urgent_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/water_cooler.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/wheel_chair.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/widow_family.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/all_category.dart';
import 'package:sadqahzakat/Screens/All_Category/Static_Category/screens/static_clothes.dart';
import 'package:sadqahzakat/Screens/All_Category/Static_Category/screens/static_daig.dart';
import 'package:sadqahzakat/Screens/All_Category/Static_Category/screens/static_meal.dart';
import 'package:sadqahzakat/Screens/All_Category/Static_Category/screens/static_quran.dart';
import 'package:sadqahzakat/Screens/All_Category/Static_Category/screens/static_rashan.dart';
import 'package:sadqahzakat/Screens/All_Category/Static_Category/screens/static_tree.dart';
import 'package:sadqahzakat/Screens/Islam/islam_main.dart';
import 'package:sadqahzakat/Screens/Login/Screen/login_page.dart';
import 'package:sadqahzakat/Screens/Need%20Support/need_support.dart';
import 'package:sadqahzakat/Screens/Notification/Screen/notification.dart';
import 'package:sadqahzakat/Screens/donation_service.dart';
import 'package:sadqahzakat/Widgets/drawers_main.dart';
import 'package:sadqahzakat/components/custom_button.dart';
// import 'package:sadqahzakat/components/help_child.dart';
// import 'package:sadqahzakat/components/homeScreen_carousel.dart';
import 'package:sadqahzakat/components/upcoming_project.dart';
import 'package:sadqahzakat/core/app_dummy.dart';
import 'package:sadqahzakat/model/all_category.dart';
import 'package:sadqahzakat/model/complete_project.dart';
import 'package:sadqahzakat/model/doantion_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:video_thumbnail/video_thumbnail.dart';

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
    // createTutorial();
    // Future.delayed(Duration.zero, showTutorial);
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
                          backgroundColor: const Color(0xFF7fc23a),
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
        body: ListView(
          // child: Column(
          children: const [
            HomeH1(),
            ReelsSection(),
            StaticCategory(),
            // CarouselHome(),
            DisplayCategory(),
            FinalCard(),
            UpComingRender(),
          ],
          // ),
        ),
      ),
    );
  }
}

class UpComingRender extends StatefulWidget {
  const UpComingRender({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UpComingRenderState createState() => _UpComingRenderState();
}

class _UpComingRenderState extends State<UpComingRender> {
  late Future<List<CompleteProject>> futureProjects;

  @override
  void initState() {
    super.initState();
    futureProjects =
        fetchProjects(); // Fetch projects when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CompleteProject>>(
      future: futureProjects,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Complete projects'));
        } else {
          List<CompleteProject> projects = snapshot.data!.take(3).toList();

          return Column(
            children: [
              const Text(
                "Our Complete Projects",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Roboto"),
              ),
              const SizedBox(
                width: 300,
                child: Divider(
                  thickness: 5,
                  color: Color(0xFF7fc23a),
                  height: 30,
                ),
              ),
              // Dynamically load each project
              for (var project in projects) ...[
                OurCompleteProject(
                  image: NetworkImage(project.image),
                  text1: project.text1,
                  text2: project.text2,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 25, 25),
                  child: Text(
                    project.detail,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        fontFamily: "Roboto"),
                  ),
                ),
              ],
            ],
          );
        }
      },
    );
  }
}

class OurCompleteProject extends StatelessWidget {
  const OurCompleteProject(
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
                      top: 5,
                      right: 5,
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

class HomeH1 extends StatefulWidget {
  const HomeH1({super.key});

  @override
  State<HomeH1> createState() => _HomeH1State();
}

class _HomeH1State extends State<HomeH1> {
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

class HomeH2 extends StatefulWidget {
  const HomeH2({super.key});

  @override
  State<HomeH2> createState() => _HomeH2State();
}

class _HomeH2State extends State<HomeH2> {
  String? username = "unknown";

  Future<void> _getname() async {
    String? fetchedUsername = await storage.read(key: 'user_name');
    if (fetchedUsername != null) {
      setState(() {
        username = fetchedUsername; // Update username and rebuild UI
      });
    } else {
      username = "unknown"; // Fallback if no username is found in storage
    }
    // print(username);
  }

  @override
  void initState() {
    super.initState();
    _getname();
  }
  // String? username;

  @override
  Widget build(BuildContext context) {
    // print(username);
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Container(
            height: 130,
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
                  // ignore: deprecated_member_use
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
                          width: 50,
                          height: 50,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Aslam O Alaikum, \n $username',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // SizedBox(height: 10),
                            const Text(
                              'Is your zakat payment up to date?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
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
                                          NotificationMain()));
                            },
                            icon: const Icon(
                              FontAwesomeIcons.bell,
                              color: Colors.white,
                              // size: 15,
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
        // ignore: use_build_context_synchronously
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
        height: 90,
        // color: Colors.red,
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonNavBar(
              key: keyButton,
              text: 'Islam',
              fontawesome: FontAwesomeIcons.mosque,
              navigateTo: const IslamScreen(),
            ),
            ButtonNavBar(
              key: keyButton1,
              text: 'Need Support',
              fontawesome: FontAwesomeIcons.handshake,
              navigateTo: const NeedCategory(),
            ),
            ButtonNavBar(
              key: keyButton2,
              text: 'Urgent Donation',
              fontawesome: FontAwesomeIcons.bullhorn,
              navigateTo: const UrgentDonation(),
            ),
          ],
        ),
      ),
    );
  }

  // void showTutorial() {
  //   tutorialCoachMark.show(context: context);
  // }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: const Color.fromARGB(255, 73, 174, 45),
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        // print("finish");
      },
      onClickTarget: (target) {
        // print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        // print("target: $target");
        // print(
        // "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        // print('onClickOverlay: $target');
      },
      onSkip: () {
        // print("skip");
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
        identify: "Target 1",
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
        identify: "Target 2",
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
                    // ignore: deprecated_member_use
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

class ReelsSection extends StatefulWidget {
  const ReelsSection({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReelsSectionState createState() => _ReelsSectionState();
}

class _ReelsSectionState extends State<ReelsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Map<String, dynamic>> videoData = [];
  List<String?> thumbnails = [];
  Set<String> viewedVideos = {};
  List<String> downloadedVideos = [];
  bool isLoading = true;
  late Directory videoDirectory;
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    initApp();
  }

  Future<void> initApp() async {
    videoDirectory = await getApplicationDocumentsDirectory();
    await Future.wait([_loadDownloadedVideos(), _syncWithServer()]);
    await _generateThumbnails();
    setState(() => isLoading = false);
  }

  Future<void> _loadDownloadedVideos() async {
    final prefs = await SharedPreferences.getInstance();
    downloadedVideos = prefs.getStringList('downloadedVideos') ?? [];
    viewedVideos = prefs.getStringList('viewedVideos')?.toSet() ?? {};
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('downloadedVideos', downloadedVideos);
    await prefs.setStringList('viewedVideos', viewedVideos.toList());
  }

  Future<void> _syncWithServer() async {
    const apiUrl = 'https://sadqahzakaat.com/data/videos/';
    try {
      final response = await dio.get(apiUrl);
      if (response.statusCode == 200) {
        final List<dynamic> serverVideos = response.data;
        // print(serverVideos);
        // Download new videos and remove obsolete ones in parallel
        final serverVideoUrls =
            serverVideos.map((video) => video['video'] as String).toList();
        final newVideos = serverVideos
            .where((video) => !downloadedVideos.contains(video['video']))
            .toList();
        final obsoleteVideos = downloadedVideos
            .where((video) => !serverVideoUrls.contains(video))
            .toList();

        await Future.wait([
          ...newVideos.map((video) => _downloadVideo(video['video'])),
          ...obsoleteVideos.map((video) => _deleteVideo(video))
        ]);

        downloadedVideos = serverVideoUrls;
        videoData = serverVideos
            .map((item) => {'url': item['video'], 'title': item['title']})
            .toList();

        await _savePreferences();
      }
    } catch (e) {
      // print("Error syncing with server: $e");
    }
  }

  Future<void> _downloadVideo(String videoUrl) async {
    final filePath = '${videoDirectory.path}/${videoUrl.split('/').last}';
    try {
      await dio.download("https://sadqahzakaat.com$videoUrl", filePath);
    } catch (e) {
      // print("Error downloading video: $e");
    }
  }

  Future<void> _deleteVideo(String videoUrl) async {
    final filePath = '${videoDirectory.path}/${videoUrl.split('/').last}';
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
// Future<void> _generateThumbnails() async {
//   final plugin = FcNativeVideoThumbnail();

//   thumbnails = await Future.wait(videoData.map((video) async {
//     final thumbnailPath =
//         '${videoDirectory.path}/thumbnail_${video['url'].split('/').last}.png';

//     // Check if the thumbnail already exists
//     if (File(thumbnailPath).existsSync()) {
//       return thumbnailPath;
//     }

//     try {
//       // Generate thumbnail using FcNativeVideoThumbnail
//       final generatedThumbnail = await plugin.getVideoThumbnail(
//         srcFile: "http://127.0.0.1:8000${video['url']}", // Full network URL
//         destFile: thumbnailPath, // Path to save the thumbnail
//         width: 250, // Thumbnail width
//         height: 250, // Thumbnail height
//         quality: 75, // Thumbnail quality
//       );

//       if (generatedThumbnail == false) {
//         print("Thumbnail generation failed for: ${video['url']}");
//         return null;
//       }

//       return generatedThumbnail ? thumbnailPath : null;
//     } catch (e) {
//       print("Error generating thumbnail: $e");
//       return null;
//     }
//   }).toList());
// }

  // Future<void> _generateThumbnails() async {
  //   thumbnails = await Future.wait(videoData.map((video) async {
  //     final thumbnailPath =
  //         '${videoDirectory.path}/thumbnail_${video['url'].split('/').last}.png';

  //     // Check if the thumbnail already exists
  //     if (File(thumbnailPath).existsSync()) {
  //       return thumbnailPath;
  //     }

  //     try {
  //       // print("Generating thumbnail for network video: ${video['url']}");

  //       // Generate thumbnail from network video
  //       print("http://127.0.0.1:8000${video['url']}");
  //       final thumbnail = await VideoThumbnail.thumbnailFile(
  //         video: "http://127.0.0.1:8000${video['url']}", // Full network URL
  //         thumbnailPath: thumbnailPath, // Optional; will save to this path
  //         imageFormat: ImageFormat.PNG,
  //         maxHeight: 250,
  //         quality: 75,
  //       );

  //       if (thumbnail != null) {
  //         // print("Thumbnail generated: $thumbnail");
  //         return thumbnail; // Return the generated thumbnail path
  //       } else {
  //         // print("Thumbnail generation failed for: ${video['url']}");
  //         return null;
  //       }
  //     } catch (e) {
  //       // print("Error generating thumbnail: $e");
  //       return null; // Return null in case of an error
  //     }
  //   }).toList());
  // }
  Future<void> _generateThumbnails() async {
    thumbnails = await Future.wait(videoData.map((video) async {
      final videoPath =
          '${videoDirectory.path}/${video['url'].split('/').last}';
      final thumbnailPath =
          '${videoDirectory.path}/thumbnail_${video['url'].split('/').last}.png';
      print(videoPath);
      // Check if the thumbnail already exists
      if (File(thumbnailPath).existsSync()) {
        return thumbnailPath;
      }

      try {
        final plugin = FcNativeVideoThumbnail();
        // Generate thumbnail using fc_native_video_thumbnail
        final generatedThumbnail = await plugin.getVideoThumbnail(
          srcFile: videoPath,
          destFile: thumbnailPath,
          width: 250,
          height: 250,
          quality: 75,
        );
        if (generatedThumbnail == false) {
          print("Thumbnail generation failed for: $videoPath");
          return null;
        }
        return generatedThumbnail
            ? thumbnailPath
            : null; // Return the generated thumbnail path
      } catch (e) {
        print("Error generating thumbnail: $e");
        return null; // Return null in case of an error
      }
    }));
  }

  Color getAnimatedBorderColor(String url) {
    return viewedVideos.contains(url)
        ? Colors.grey
        : ColorTween(begin: Colors.green, end: Colors.lightGreen)
                .evaluate(_controller) ??
            Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Reels Section",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: videoData.length,
                  itemBuilder: (context, index) {
                    final video = videoData[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          viewedVideos.add(video['url']);
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ReelsPage(videoUrl: video['url']),
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
                                        color: getAnimatedBorderColor(
                                            video['url']),
                                        width: 3.0),
                                    borderRadius: BorderRadius.circular(100.0),
                                    image: thumbnails.isNotEmpty &&
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
                              video['title'],
                              style: const TextStyle(
                                  fontSize: 10,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.black),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ReelsPage extends StatelessWidget {
  final String videoUrl;

  const ReelsPage({super.key, required this.videoUrl});

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

class ReelVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ReelVideoPlayer({super.key, required this.videoUrl});

  @override
  // ignore: library_private_types_in_public_api
  _ReelVideoPlayerState createState() => _ReelVideoPlayerState();
}

class _ReelVideoPlayerState extends State<ReelVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller =
        // ignore: deprecated_member_use
        VideoPlayerController.network(
            "https://sadqahzakaat.com${widget.videoUrl}")
          ..initialize().then((_) {
            setState(() {
              _controller.play();
            });
          }).catchError((error) {
            // print("Error initializing video: $error");
          });

    _controller.addListener(() {
      if (_controller.value.isInitialized &&
          _controller.value.position >= _controller.value.duration) {
        Navigator.pop(context); // Go back to home screen when video completes
      }
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
    // print(widget.videoUrl);
    return Center(
      child: _controller.value.isInitialized
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(
                  value: _controller.value.position.inMilliseconds /
                      _controller.value.duration.inMilliseconds,
                ),
                GestureDetector(
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
                ),
              ],
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
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.7, // Adjust width
            height: 525,
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
                          "https://sadqahzakaat.com/data${widget.imageUrl}"),
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
      height: 70,
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
                fontSize: 14,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
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
                      navigate: BloodMain(),
                      // navigate: const BloodDetailCard(),
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
                      navigate: const SmallBusiness(),
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
    // double screenWidth = MediaQuery.of(context).size.width;
    // double height = (screenWidth < 400) ? 750 : 780;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Group Category",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7fc23a)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllCategoryGroup(),
                      // builder: (context) => const QiblaApp(),
                    ),
                  );
                },
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
        const CategoryGrid(),
      ],
    );
  }
}

// class CategoryGrid extends StatelessWidget {
//   const CategoryGrid({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     int crossAxisCount = (screenWidth < 600)
//         ? 3
//         : (screenWidth < 900)
//             ? 4
//             : 5;

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: crossAxisCount,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemCount: availableCategories.length,
//         itemBuilder: (context, index) {
//           final category = availableCategories[index];
//           return CategoryTile(
//             category: category,
//             onSelectCategory: () {
//               Navigator.pushNamed(context, category.route);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
class CategoryGrid extends StatefulWidget {
  const CategoryGrid({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
        await http.get(Uri.parse('https://sadqahzakaat.com/data/categories/'));
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
      // return const TreeDonation();
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
      case '/Gaza':
        return const Gaza();
      case '/Blood':
        return const BloodMain();
      default:
        // print('Unknown route tapped: $route');
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
    // double childAspectRatio = (screenWidth < 400) ? 3 / 3.9 : 3 / 4;
    // double childAspectRatio = (screenWidth < 400) ? 2 / 3.5 : 3 / 4;

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
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: GridView.builder(
            shrinkWrap: true,
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              // childAspectRatio: childAspectRatio,
            ),
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              final category = categoryList[index];
              return CategoryTile(
                category: category,
                onSelectCategory: () {
                  // print("Navigating to: ${category.route}");
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

class StaticCategory extends StatelessWidget {
  const StaticCategory({super.key});

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double height = (screenWidth < 400) ? 370 : 330;
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Single Category",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7fc23a)),
              ),
            ],
          ),
        ),
        SizedBox(
          child: StaticCategoryGrid(),
        ),
      ],
    );
  }
}

class StaticCategoryGrid extends StatefulWidget {
  const StaticCategoryGrid({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StaticCategoryGridState createState() => _StaticCategoryGridState();
}

class _StaticCategoryGridState extends State<StaticCategoryGrid> {
  late Future<List<AllCategoryModel>> categories;

  @override
  void initState() {
    super.initState();
    categories = fetchCategories();
  }

  // Fetch categories from API
  Future<List<AllCategoryModel>> fetchCategories() async {
    final response = await http
        .get(Uri.parse('https://sadqahzakaat.com/data/staticcategories/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => AllCategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Route mapping function
  Widget getRouteWidget1(String route) {
    switch (route) {
      case '/DaigDonation3':
        return const StaticDaig();
      case '/Clothes3':
        return const StaticClothes();
      case '/MealDonation3':
        return const StaticMeal();
      case '/Quran3':
        return const StaticQuran();
      case '/TreeDonation3':
        return const StaticTree();
      case '/Rashan3':
        return const StaticRashan();
      default:
        // print('Unknown route tapped: $route');
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
    // double childAspectRatio = (screenWidth < 400) ? 3 / 3.9 : 3 / 4;
    // double childAspectRatio = (screenWidth < 400) ? 2 / 3.5 : 3 / 4;

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
          //         padding: EdgeInsets.only(
          //   bottom: MediaQuery.of(context).viewInsets.bottom, // Handle insets
          // ),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            // physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              final category = categoryList[index];
              return CategoryTile(
                category: category,
                onSelectCategory: () {
                  // print("Navigating to: ${category.route}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => getRouteWidget1(category.route),
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
