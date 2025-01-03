import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/All_Category/Static_Category/components/static_other_donation.dart';
// import 'package:sadqahzakat/Screens/All_Category/Static_Category/components/static_clothes.dart';
// import 'package:sadqahzakat/model/doantion_model.dart';

class StaticTree extends StatelessWidget {
  const StaticTree({super.key});

  @override
  Widget build(BuildContext context) {
    return const StaticTreeCard();
  }
}

class StaticTreeCard extends StatefulWidget {
  // final List<Donation> donations; // List of donations passed to the widget

  const StaticTreeCard({
    super.key,
  });

  @override
  State<StaticTreeCard> createState() => _StaticTreeCardState();
}

class _StaticTreeCardState extends State<StaticTreeCard> {
  final List<Map<String, dynamic>> donationOptionsmeal = [
    {'title': 'Naeem', 'price': 100},
    {'title': 'Apple Tree', 'price': 250},
    {'title': 'White Tree', 'price': 350},
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
        title: const Text("Static Tree Donation"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
          StaticOtherDesign(
            imageUrl: "assets/images/static_donation/tree.png",
            description: "xyz..........",
            donationOptions: donationOptionsmeal, selectcategory: 'statictree', title: 'statictree',
          ),
        ])),
      ),
      // ),
    );
  }
}
