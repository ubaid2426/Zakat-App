import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/All_Category/Static_Category/components/static_other_donation.dart';
// import 'package:sadqahzakat/Screens/All_Category/Static_Category/components/static_clothes.dart';

// import 'package:sadqahzakat/model/doantion_model.dart';
class StaticMeal extends StatelessWidget {
  const StaticMeal({super.key});

  @override
  Widget build(BuildContext context) {
    return const StaticMealCard();
  }
}

class StaticMealCard extends StatefulWidget {
  // final List<Donation> donations; // List of donations passed to the widget

  const StaticMealCard({
    super.key,
  });

  @override
  State<StaticMealCard> createState() => _StaticMealCardState();
}

class _StaticMealCardState extends State<StaticMealCard> {
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
        title: const Text("Static Meal Donation"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
          StaticOtherDesign(
            imageUrl: "assets/images/static_donation/meal.png",
            description: "abc..........",
            donationOptions: donationOptionsmeal, selectcategory: 'staticmeal', title: 'staticmeal',
          ),
        ])),
      ),
      // ),
    );
  }
}