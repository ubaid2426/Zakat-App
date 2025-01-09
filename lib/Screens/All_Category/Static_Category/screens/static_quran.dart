import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/All_Category/Static_Category/components/static_other_donation.dart';
// import 'package:sadqahzakat/Screens/All_Category/Static_Category/components/static_clothes.dart';

// import 'package:sadqahzakat/model/doantion_model.dart';
class StaticQuran extends StatelessWidget {
  const StaticQuran({super.key});

  @override
  Widget build(BuildContext context) {
    return const StaticQuranCard();
  }
}

class StaticQuranCard extends StatefulWidget {
  // final List<Donation> donations; // List of donations passed to the widget

  const StaticQuranCard({
    super.key,
  });

  @override
  State<StaticQuranCard> createState() => _StaticQuranCardState();
}

class _StaticQuranCardState extends State<StaticQuranCard> {
  final List<Map<String, dynamic>> donationOptionsmeal = [
    {'title': 'Juzs', 'price': 150},
    {'title': 'Small Words', 'price': 1000},
    {'title': 'Big Words', 'price': 2500},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Static Quran Donation"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
          StaticOtherDesign(
            imageUrl: "assets/images/static_donation/download.jpeg",
            description: "xyz..........",
            donationOptions: donationOptionsmeal, selectcategory: 'staticquran', title: 'staticquran',
          ),
        ])),
      ),
      // ),
    );
  }
}
