import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/All_Category/Static_Category/components/static_clothes.dart';

// import 'package:sadqahzakat/model/doantion_model.dart';
class StaticClothes extends StatelessWidget {
  const StaticClothes({super.key});

  @override
  Widget build(BuildContext context) {
    return StaticClothesCard();
  }
}

class StaticClothesCard extends StatefulWidget {
  // final List<Donation> donations; // List of donations passed to the widget

  StaticClothesCard({
    super.key,
  });

  @override
  State<StaticClothesCard> createState() => _StaticClothesCardState();
}

class _StaticClothesCardState extends State<StaticClothesCard> {
  final List<Map<String, dynamic>> donationOptionsmeal = [
    {'title': 'Kid', 'price': 1000},
    {'title': 'Adult', 'price': 2500},
    {'title': 'Young', 'price': 3500},
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
        title: const Text("Static Clothes Donation"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
          StaticClothesDesign(
            imageUrl: "assets/images/static_donation/clothes.png",
            description: "Static Clothes Donation",
            donationOptions: donationOptionsmeal,
            // age: '',
            selectcategory: 'staticclothes',
            // headingcategory: '',
            // gender: '',
          ),
        ])),
      ),
      // ),
    );
  }
}
