import 'package:flutter/material.dart';
import 'package:sadqahzakat/controller/fade_animation.dart';
// import 'package:zakat_app/Screens/All_Category/all_category.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/all_category.dart';
// import 'package:zakat_app/controller/fade_animation.dart';

class H1Main extends StatelessWidget {
  const H1Main({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 700,
        child: Stack(
          children: [
            FadeAnimation(
              animationType: 'ZoomIn',
              delay: 500,
              child: Container(
                // color: const Color.fromARGB(16, 0, 0, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                // height: 700,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'Assests/images/screen1/10012.png'), // Adjust the image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                color: const Color.fromARGB(181, 0, 0, 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                // color: const Color.fromARGB(181, 178, 33, 33),
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Color(0xFF000000),
                    // AssetImage("Assests/images/screen1/hand2.png"),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'Assests/images/screen1/folder.png'), // Adjust the image path
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width * 0.50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'Assests/images/screen1/manyhand.png'), // Adjust the image path
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'Assests/images/screen1/komo.png'), // Adjust the image path
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Overlay text and button
            Align(
              alignment: Alignment.center, // Adjust the alignment of the text
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const FadeAnimation(
                      animationType: "FadeInRight",
                      delay: 1000,
                      child: Text(
                        "100+ PROJECTS ACROSS THE GLOBE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 2,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const FadeAnimation(
                      animationType: "FadeInLeft",
                      delay: 1000,
                      child: Text(
                        "Empowering Communities, Changing Lives",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontFamily: "Cormorant",
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const FadeAnimation(
                      animationType: "FadeInRight",
                      delay: 1000,
                      child: Text(
                        "We work towards ensuring a life of dignity, opportunity, and hope for all.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.536,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Cormorant",
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the donation page
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => AllCategory()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF29C77B), // Button color
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        "DONATE",
                        style: TextStyle(
                          fontSize: 18.8,
                          fontFamily: "Roboto",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
