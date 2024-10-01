import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:zakat_app/Screens/All_Category/Screen/clothes.dart';
import 'package:zakat_app/Screens/All_Category/Screen/masjid_maintenance.dart';
import 'package:zakat_app/Screens/All_Category/Screen/portable_house.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/individual_donation.dart';
import 'package:zakat_app/Screens/All_Category/Screen/request_donation.dart';
import 'package:zakat_app/Screens/All_Category/all_category.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/all_category.dart';
import 'package:zakat_app/Screens/Calculator/Calculator.dart';
import 'package:zakat_app/Screens/History/history_main.dart';
// import 'package:zakat_app/Screens/Home/components/food_donation.dart';
import 'package:zakat_app/Screens/Islam/islam_main.dart';
import 'package:zakat_app/Screens/Need%20Support/need_support.dart';
// import 'package:zakat_app/Screens/Need%20Support/need_support.dart';
// import 'package:zakat_app/Screens/New%20Campaign/new_campaign.dart';
import 'package:zakat_app/Screens/Notification/Screen/notification.dart';
import 'package:zakat_app/Widgets/drawers_main.dart';
import 'package:zakat_app/components/custom_button.dart';
// import 'package:zakat_app/components/H1Main.dart';
import 'package:zakat_app/components/help_child.dart';
import 'package:zakat_app/components/homeScreen_carousel.dart';
// import 'package:zakat_app/components/navigation.dart';
import 'package:zakat_app/components/upcoming_project.dart';
import 'package:zakat_app/controller/fade_animation.dart';
import 'package:zakat_app/core/app_dummy.dart';
import 'package:zakat_app/model/doantion_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

bool _hasShownLoginDialog = false;

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
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
              height: 320,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please log in to take advantage of the wallet and the advanced notifications',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.login,
                    size: 100,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle login action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
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
              // UpComingRender(),
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
}

class MainCategory extends StatelessWidget {
  const MainCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "All categories",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7fc23a)),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "see more",
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
        const SizedBox(
          width: double.infinity,
          height: 600,
          // color: Colors.pink,
          child: Category(),
        ),
      ],
    );
  }
}

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
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AllCategory()));
            },
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
    return Container(
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
                // const SizedBox(
                //   height: 50,
                // ),
                Container(
                  // color: Colors.red,
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

class HomeH3 extends StatelessWidget {
  const HomeH3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        height: 100,
        // color: Colors.red,
        width: MediaQuery.of(context).size.width - 60,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonNavBar(
              text: 'Zakat\nCalculator',
              fontawesome: FontAwesomeIcons.bell,
              navigateTo: ZakatCalculator(),
            ),
            const ButtonNavBar(
              text: 'Islam',
              fontawesome: FontAwesomeIcons.mosque,
              navigateTo: IslamScreen(),
            ),
            ButtonNavBar(
              text: 'Need Support',
              fontawesome: FontAwesomeIcons.handshake,
              navigateTo: NeedCategory(),
            ),
            const ButtonNavBar(
              text: 'History',
              fontawesome: FontAwesomeIcons.rotateLeft,
              navigateTo: DonationHistory(),
            ),
          ],
        ),
      ),
    );
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
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => navigateTo), // Navigate to the screen
        );
      },
      child: Column(
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
    );
  }
}

class ReelsSection extends StatefulWidget {
  const ReelsSection({Key? key}) : super(key: key);

  @override
  _ReelsSectionState createState() => _ReelsSectionState();
}

class _ReelsSectionState extends State<ReelsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<String> videoUrls = [
    'https://raw.githubusercontent.com/ubaid2426/Zakat-App/main/Assests/videos/WhatsApp%20Video%202024-09-26%20at%2019.28.59.mp4',
    'https://raw.githubusercontent.com/ubaid2426/Zakat-App/main/Assests/videos/WhatsApp%20Video%202024-09-26%20at%2019.29.32.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://youtube.com/shorts/Mjg5_3eusu4?si=Uw1ZA0lXWfufbWd8',
    'https://www.instagram.com/reel/C2kqKyViKMM/?igsh=MW92NjZrZ2N5NG90ag==', // Add your video URLs
  ];

  final List<String> reelTitles = [
    "Orphan Home",
    "ISAAR AMDC",
    "New 3",
    "YouTube Short",
    "Instagram Reel",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
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
          height: 150, // Increased height to accommodate titles
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                videoUrls.length,
                (index) => GestureDetector(
                  onTap: () {
                    // Navigate to the full-screen reel page with the selected video URL
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReelsPage(videoUrl: videoUrls[index]),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            Color borderColor = getAnimatedBorderColor();
                            return Container(
                              width: 100,
                              height:
                                  100, // Fixed height for the video thumbnail
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF33A248),
                                    Color(0xFFB2EA50)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                border:
                                    Border.all(color: borderColor, width: 3.0),
                                borderRadius: BorderRadius.circular(100.0),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'Assests/images/AllCategory/medicalbed.png'), // Update the image path
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                            height: 5), // Spacing between thumbnail and title
                        Text(
                          reelTitles[index], // Display the title of the reel
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReelsPage extends StatelessWidget {
  final String videoUrl;

  const ReelsPage({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Reel Video')),
      body: Center(
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          // itemCount: videoUrls.length,
          itemBuilder: (context, index) {
            return ReelVideoPlayer(videoUrl: videoUrl);
          },
        ),
      ),
    );
  }
}

class ReelVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ReelVideoPlayer({super.key, required this.videoUrl});

  @override
  _ReelVideoPlayerState createState() => _ReelVideoPlayerState();
}

class _ReelVideoPlayerState extends State<ReelVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _isPlaying = true;
        });
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
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF33A248), // First color (#33A248)
                Color(0xFFB2EA50), // Second color (#B2EA50)
              ],
              begin:
                  Alignment.bottomRight, // Start the gradient from bottom-right
              end: Alignment.topLeft, // End the gradient at top-left
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: _controller.value.isInitialized
            ? GestureDetector(
                onTap: _togglePlayPause, // Toggle play/pause on tap
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
      ),
    );
  }
}

// LeftToRight widget that receives a list of filtered projects
class LeftToRight extends StatelessWidget {
  final Widget navigate;
  final List<DoantionModel> projects;

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
            projectvalue: project.projectvalue,
            paidvlaue: project.paidvlaue,
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
  final double projectvalue;
  final double paidvlaue;
  final String title;
  final String imageUrl;
  final String description;
  final Widget navigate;

  const PerCategory({
    super.key,
    required this.projectvalue,
    required this.paidvlaue,
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
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.asset(
                    widget.imageUrl, // Ensure path is correct
                    fit: BoxFit.cover,
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
              'Rs ${widget.projectvalue.toInt()}', 'Project Value'),
          buildProjectInfo('${widget.paidvlaue.toInt()}', 'Paid'),
          buildProjectInfo(
            'Rs ${(widget.projectvalue - widget.paidvlaue).toInt()}',
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
    double progress = widget.paidvlaue / widget.projectvalue;
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

// Example usage in the HomePage
class FinalCard extends StatelessWidget {
  const FinalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "All categories Card",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7fc23a),
            ),
            textAlign: TextAlign.start,
          ),
        ),
        DataPutHome(),
      ],
    );
  }

  Widget DataPutHome() {
    // Filter the not finished projects for each category
    List<DoantionModel> notFinishedClothes = filterNotFinishedProjects(clothes);
    List<DoantionModel> notFinishedMasjidmaintenance =
        filterNotFinishedProjects(masjidmaintenance);
    List<DoantionModel> notFinishedMarriagesupport =
        filterNotFinishedProjects(marriagesupport);
    List<DoantionModel> notFinishedFloodrelief =
        filterNotFinishedProjects(floodrelief);
    List<DoantionModel> notFinishedWidowfamily =
        filterNotFinishedProjects(widowfamily);
    List<DoantionModel> notFinishedMedicalbed =
        filterNotFinishedProjects(medicalbed);
    List<DoantionModel> notFinishedWheelchair =
        filterNotFinishedProjects(wheelchair);
    List<DoantionModel> notFinishedTreedonation =
        filterNotFinishedProjects(treedonation);
    List<DoantionModel> notFinishedDaigdonation =
        filterNotFinishedProjects(daigdonation);
    List<DoantionModel> notFinishedmealdonation =
        filterNotFinishedProjects(mealdonation);
    List<DoantionModel> notFinishedOrphansupport =
        filterNotFinishedProjects(orphansupport);
    List<DoantionModel> notFinishedWaterCooler =
        filterNotFinishedProjects(waterCooler);
    List<DoantionModel> notFinishedOther = filterNotFinishedProjects(other);
    List<DoantionModel> notFinishedPortableHouse =
        filterNotFinishedProjects(portablehouse);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 650,
        child: Row(
          children: [
            LeftToRight(
              projects: notFinishedClothes,
              navigate: const Clothes(),
            ),
            LeftToRight(
              projects: notFinishedPortableHouse,
              navigate: const PortableHouse(),
            ),
            LeftToRight(
              projects: notFinishedMasjidmaintenance,
              navigate: const MasjidMaintenance(),
            ),
            LeftToRight(
              projects: notFinishedPortableHouse,
              navigate: const PortableHouse(),
            ),
            LeftToRight(
              projects: notFinishedPortableHouse,
              navigate: const PortableHouse(),
            ),
            LeftToRight(
              projects: notFinishedPortableHouse,
              navigate: const PortableHouse(),
            ),
            LeftToRight(
              projects: notFinishedPortableHouse,
              navigate: const PortableHouse(),
            ),
            LeftToRight(
              projects: notFinishedPortableHouse,
              navigate: const PortableHouse(),
            ),
            LeftToRight(
              projects: notFinishedPortableHouse,
              navigate: const PortableHouse(),
            ),
            LeftToRight(
              projects: notFinishedPortableHouse,
              navigate: const PortableHouse(),
            ),
            LeftToRight(
              projects: notFinishedPortableHouse,
              navigate: const PortableHouse(),
            ),
          ],
        ),
        // ),
      ),
    );
  }
}

class DisplayCategory extends StatelessWidget {
  const DisplayCategory({super.key});

  @override
  Widget build(BuildContext context) {
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
                  "see more",
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
        Container(
          // color: Colors.black,
          height: 1350,
          child: const Category(),
        ),
      ],
    );
  }
}

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          child: GridView.builder(
            shrinkWrap: true, // Ensures GridView does not expand indefinitely.
            primary: false,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 3.4, // Aspect ratio for the grid items
            ),
            itemCount: availableCategories.length, // Dynamic item count
            itemBuilder: (context, index) {
              final category = availableCategories[index];
              return Show1(
                category: category,
                onSelectCategory: () {
                  print("Navigating to: ${category.route}");
                  final selectedCategory = availableCategories
                      .firstWhere((element) => element.id == category.id);
                  Navigator.pushNamed(context, selectedCategory.route);
                  // Navigator.pushNamed(context, category.route);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
