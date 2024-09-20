import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:zakat_app/Screens/All_Category/Screen/individual_donation.dart';
import 'package:zakat_app/Screens/All_Category/Screen/request_donation.dart';
import 'package:zakat_app/Screens/All_Category/all_category.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/all_category.dart';
import 'package:zakat_app/Screens/Calculator/Calculator.dart';
import 'package:zakat_app/Screens/Home/components/food_donation.dart';
// import 'package:zakat_app/Screens/Need%20Support/need_support.dart';
// import 'package:zakat_app/Screens/New%20Campaign/new_campaign.dart';
import 'package:zakat_app/Screens/Notification/Screen/notification.dart';
import 'package:zakat_app/Widgets/drawers_main.dart';
// import 'package:zakat_app/components/H1Main.dart';
import 'package:zakat_app/components/help_child.dart';
import 'package:zakat_app/components/homeScreen_carousel.dart';
// import 'package:zakat_app/components/navigation.dart';
import 'package:zakat_app/components/upcoming_project.dart';
import 'package:zakat_app/controller/fade_animation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //  @override
  // void initState() {
  //   super.initState();
  //   // Show the dialog as soon as the widget is loaded
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     showFoodDialog(context);
  //   });
  // }

  void showFoodDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // content: const Text('Choose your donation option:'),
          actions: <Widget>[
            TextButton(
              child: const Text('Individual Donation'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IndividualDonation(),
                  ),
                );
              },
            ),
            TextButton(
              child: const Text('Request For Donation'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestDonation(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
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
              MainCategory(),
              // H1Main(),
              BoxText(),
              SizedBox(
                height: 50,
              ),
              MarriageSupportH(
                h3: "Our Numbers",
                h1: 'Rs.100000+',
                h2: 'Meal Donations',
                fontawesome: FontAwesomeIcons.faceDizzy,
              ),
              MarriageSupportH(
                h1: 'Rs.400000+',
                h2: 'Flood Donations',
                fontawesome: FontAwesomeIcons.bolt,
              ),
              MarriageSupportH(
                h1: 'Rs.200000+',
                h2: 'Medical Donations',
                fontawesome: FontAwesomeIcons.houseChimneyUser,
              ),
              MarriageSupportH(
                h1: 'Rs.300000+',
                h2: 'Marriage Support',
                fontawesome: FontAwesomeIcons.solidHeart,
              ),
              SizedBox(
                height: 50,
              ),
              FoodDonation(),
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
                  onPressed: () {

                  },
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
            
      const  SizedBox(
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
      height: 300,
      child: Column(
        children: [
          Container(
            height: 230,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: TextField(
                    // controller: ,
                    decoration: InputDecoration(
                      hintText: 'Zakat Profession etc....',
                      prefixIcon:
                          const Icon(Icons.search), // Search icon provided here
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.white, // Default border color
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors
                              .white, // Border color when the field is enabled
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors
                              .white, // Border color when the field is focused
                          width: 1.0, // Border thickness when focused
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
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
            ButtonNavBar(
              text: 'New Campaign',
              fontawesome: FontAwesomeIcons.bullhorn,
              navigateTo: IndividualDonation(),
            ),
            ButtonNavBar(
              text: 'Need Support',
              fontawesome: FontAwesomeIcons.handshake,
              navigateTo: RequestDonation(),
            ),
            // ButtonNavBar(
            //   text: 'All Category',
            //   fontawesome: FontAwesomeIcons.table,
            // ),
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

class MarriageSupportH extends StatelessWidget {
  final String h1;
  final String h2;
  final String? h3;
  final IconData fontawesome;
  const MarriageSupportH({
    super.key,
    required this.h1,
    required this.h2,
    required this.fontawesome,
    this.h3,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Container(
      width: MediaQuery.of(context).size.width,
      color: const Color(0xFF29C77B),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            FadeAnimation(
              animationType: 'FadeInRight',
              delay: 1000,
              child: Text(
                h3 ?? '',
                style: const TextStyle(
                  color: Color.fromARGB(255, 19, 19, 19),
                  fontSize: 40,
                  fontFamily: "Cormorant",
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            FadeAnimation(
              animationType: 'FadeInLeft',
              delay: 1000,
              child: Icon(
                fontawesome,
                size: 50,
              ),
            ),
            const SizedBox(height: 30),
            FadeAnimation(
              animationType: 'FadeInRight',
              delay: 1000,
              child: Text(
                h1,
                style: const TextStyle(
                  color: Color.fromARGB(255, 8, 8, 8),
                  fontSize: 30,
                  fontFamily: "Cormorant",
                  letterSpacing: 2,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            FadeAnimation(
              animationType: 'FadeInLeft',
              delay: 1000,
              child: Text(
                h2,
                style: const TextStyle(
                  color: Color.fromARGB(255, 8, 8, 8),
                  fontSize: 30,
                  fontFamily: "Roboto",
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

class ReelsSection extends StatelessWidget {
  const ReelsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
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
                  "see more",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 150,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                10, // Number of reels you want to display
                (index) => GestureDetector(
                  onTap: () {
                    // Navigate to the full-screen reel page on tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReelsPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ClipOval(
                      child: Container(
                        width: 120, // Width of each reel
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF33A248), Color(0xFFB2EA50)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: Color(0xFF29C77B), // Border color around the reel
                            width: 3.0,
                          ),
                        ),
                        child: Image.asset(
                          'Assests/images/AllCategory/medicalbed.png', // Replace with your asset paths
                          fit: BoxFit.cover,
                        ),
                      ),
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

class ReelsPage extends StatefulWidget {
  const ReelsPage({Key? key}) : super(key: key);

  @override
  _ReelsPageState createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  final List<String> videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://youtube.com/shorts/Mjg5_3eusu4?si=Uw1ZA0lXWfufbWd8',
    'https://www.instagram.com/reel/C2kqKyViKMM/?igsh=MW92NjZrZ2N5NG90ag==', // Replace with your video URLs
    // Add more video URLs here
  ];

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: videoUrls.length,
      itemBuilder: (context, index) {
        return ReelVideoPlayer(videoUrl: videoUrls[index]);
      },
    );
  }
}

class ReelVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const ReelVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

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
