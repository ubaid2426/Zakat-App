import 'package:flutter/material.dart';
import 'package:zakat_app/Screens/All_Category/Screen/clothes.dart';
import 'package:zakat_app/Screens/All_Category/Screen/daig_donation.dart';
import 'package:zakat_app/Screens/All_Category/Screen/food_relief.dart';
import 'package:zakat_app/Screens/All_Category/Screen/marriage_support.dart';
import 'package:zakat_app/Screens/All_Category/Screen/masjid_const.dart';
import 'package:zakat_app/Screens/All_Category/Screen/masjid_maintenance.dart';
import 'package:zakat_app/Screens/All_Category/Screen/meal_donation.dart';
import 'package:zakat_app/Screens/All_Category/Screen/medical_bed.dart';
import 'package:zakat_app/Screens/All_Category/Screen/orphan_support.dart';
import 'package:zakat_app/Screens/All_Category/Screen/other.dart';
import 'package:zakat_app/Screens/All_Category/Screen/portable_house.dart';
import 'package:zakat_app/Screens/All_Category/Screen/small_business.dart';
import 'package:zakat_app/Screens/All_Category/Screen/tree_donation.dart';
import 'package:zakat_app/Screens/All_Category/Screen/water_cooler.dart';
import 'package:zakat_app/Screens/All_Category/Screen/wheel_chair.dart';
import 'package:zakat_app/Screens/All_Category/Screen/widow_family.dart';
import 'package:zakat_app/core/app_dummy.dart';
import 'package:zakat_app/model/all_category.dart';

class AllCategory extends StatelessWidget {
  const AllCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/PortableHouse': (context) => const PortableHouse(),
        '/MasjidMaintenance': (context) => const MasjidMaintenance(),
        '/MarriageSupport': (context) => const MarriageSupport(),
        '/FloodRelief': (context) => const FloodRelief(),
        '/WidowFamily': (context) => const WidowFamily(),
        '/SmallBusinessSetup': (context) => const SmallBusiness(),
        '/Clothes': (context) => const Clothes(),
        '/MedicalBed': (context) => const MedicalBed(),
        '/WheelChair': (context) => const WheelChair(),
        '/TreeDonation': (context) => const TreeDonation(),
        '/DaigDonation': (context) => const DaigDonation(),
        '/MealDonation': (context) => const MealDonation(),
        '/OrphanSupport': (context) => const OrphanSupport(),
        '/WaterCooler': (context) => const WaterCooler(),
        '/MasjidConst': (context) => const MasjidConst(),
        '/Other': (context) => const Other(),
        // Add more routes as needed
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 195, 190, 190),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF33A248), // First color (#33A248)
                  Color(0xFFB2EA50), // Second color (#B2EA50)
                ],
                begin: Alignment
                    .bottomRight, // Start the gradient from bottom-right
                end: Alignment.topLeft, // End the gradient at top-left
              ),
            ),
          ),
          title: const Text(
            "ALL CATEGORIES",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontFamily: "Roboto",
            ),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SizedBox(
          height: 800,
          child: const Category(),
        ),
      ),
    );
  }
}

class Show extends StatelessWidget {
  const Show({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final AllCategoryModel category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      child: Container(
        height: 100,
        //  padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
        width: MediaQuery.of(context).size.width / 3 - 19,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 253, 251, 251),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              // width: 0,
              height: 50,
              child: Text(
                category.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            // SizedBox(height: 20,),
            Container(
              width: 150,
              height: 145,
              decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 245, 188,
                //     2), // Optional, for background color if the image doesn't cover
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(category.image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
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
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 3.4, // Aspect ratio for the grid items
            ),
            itemCount: availableCategories.length, // Dynamic item count
            itemBuilder: (context, index) {
              final category = availableCategories[index];
              return Show(
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
