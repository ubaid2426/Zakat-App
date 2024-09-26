import 'package:flutter/material.dart';
import 'package:zakat_app/components/homeScreen_carousel.dart';

class IslamScreen extends StatelessWidget {
  const IslamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Islam and Charity"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF33A248),
                Color(0xFFB2EA50),
              ],
              begin: Alignment.topRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Image
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/islamic_background.jpg'), // Add an image related to Islam
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Title
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "The Importance of Charity in Islam",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF33A248),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Hadith(),
              const SizedBox(height: 10),

              // Description
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Charity (Sadaqah and Zakat) is a fundamental aspect of Islam. "
                  "It is a means of purifying wealth, helping those in need, and fostering community spirit. "
                  "The Quran emphasizes charity multiple times, making it an essential practice for every Muslim.",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 10),
              // Quranic Verses Section
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Quranic Verses on Charity:",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF33A248),
                  ),
                ),
              ),
              QuranVerse(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "\"The example of those who spend their wealth in the way of Allah is like a seed of grain that sprouts into seven ears; in every ear, there are a hundred grains.\" (Quran 2:261)",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "\"And establish prayer and give zakat and obey the Messenger - that you may receive mercy.\" (Quran 24:56)",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              // Call to Action Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the donation screen or any other relevant action
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => DonationScreen()));
                },
                child: const Text("Make a Donation"),
                style: ElevatedButton.styleFrom(
                  // primary: const Color(0xFF33A248), // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}





class QuranVerse extends StatelessWidget {
  const QuranVerse({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        // color: Colors.red,
        child: const HomePageCarousel(
          imageList: [
            "Assests/images/screen1/10016.png",
            "Assests/images/screen1/10017.png",
            "Assests/images/screen1/10018.png",
          ],
          carouselHeight: 300,
        ),
      ),
    );
  }
}




class Hadith extends StatelessWidget {
  const Hadith({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        // color: Colors.red,
        child: const HomePageCarousel(
          imageList: [
            "Assests/images/screen1/10013.png",
            "Assests/images/screen1/10014.png",
            "Assests/images/screen1/10015.png",
          ],
          carouselHeight: 300,
        ),
      ),
    );
  }
}