import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/All_Category/Static_Category/components/static_other_donation.dart';
// import 'package:sadqahzakat/Screens/All_Category/Static_Category/components/static_clothes.dart';

// import 'package:sadqahzakat/model/doantion_model.dart';
class StaticRashan extends StatelessWidget {
  const StaticRashan({super.key});

  @override
  Widget build(BuildContext context) {
    return const StaticRashanCard();
  }
}

class StaticRashanCard extends StatefulWidget {
  // final List<Donation> donations; // List of donations passed to the widget

  const StaticRashanCard({
    super.key,
  });

  @override
  State<StaticRashanCard> createState() => _StaticRashanCardState();
}

class _StaticRashanCardState extends State<StaticRashanCard> {
  final List<Map<String, dynamic>> donationOptionsmeal = [
    {'title': '3 person family', 'price': 600},
    {'title': '5 person family', 'price': 1000},
    {'title': '7 person family', 'price': 2500},
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
        title: const Text("Static Rashan Donation"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
          StaticOtherDesign(
            imageUrl: "assets/images/static_donation/rashan3.jpeg",
            description: "abc..........",
            donationOptions: donationOptionsmeal,
            selectcategory: 'staticrashan',
            title: 'staticrashan',
          ),
        ])),
      ),
      // ),
    );
  }
}
