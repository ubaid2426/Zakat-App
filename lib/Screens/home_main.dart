import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zakat_app/Screens/Calculator/Calculator.dart';
import 'package:zakat_app/Screens/Need%20Support/need_support.dart';
import 'package:zakat_app/Screens/New%20Campaign/new_campaign.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  // final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [HomeH1()],
    );
  }
}


class CarouselHome extends StatelessWidget {
  const CarouselHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        // color: Colors.red,
        child: const HomePageCarousel(
          imageList: [
            "Assests/Images/10007.png",
            "Assests/Images/10008.png",
            "Assests/Images/10009.png",
            "Assests/Images/10010.png",
            "Assests/Images/10011.png",
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
              color: const Color(0xFF3973E5),
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
                                    'Assests/images/screen1/10001.png'), // Adjust the image path
                                fit: BoxFit.cover, // Adjust the fit as needed
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
                              'Have You Paid Zakat?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
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
                            onPressed: () {},
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonNavBar(
              text: 'Calculator',
              fontawesome: FontAwesomeIcons.bell,
              navigateTo: Calculator(),
            ),
            ButtonNavBar(
              text: 'New Campaign',
              fontawesome: FontAwesomeIcons.bullhorn,
              navigateTo: NewCampaign(),
            ),
            ButtonNavBar(
              text: 'Need Support',
              fontawesome: FontAwesomeIcons.handshake,
              navigateTo: NeedSupport(),
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
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
