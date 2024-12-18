import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/blood_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/clothes.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/daig_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/food_relief.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/marriage_support.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/masjid_const.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/masjid_maintenance.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/meal_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/medical_bed.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/orphan_support.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/other.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/portable_house.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/small_business.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/tree_donation.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/water_cooler.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/wheel_chair.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/widow_family.dart';
import 'package:sadqahzakat/model/all_category.dart';

class AllCategoryGroup extends StatelessWidget {
  const AllCategoryGroup({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double height = (screenWidth < 400) ? 800 : 1300;

    return MaterialApp(
      routes: {
        '/PortableHouse': (context) => const PortableHouse(),
        '/MasjidMaintenance': (context) => const MasjidMaintenance(),
        '/MarriageSupport': (context) => const MarriageSupport(),
        '/FloodRelief': (context) => const FloodRelief(),
        '/WidowFamily': (context) => const WidowFamily(),
        '/SmallBusinessSetup': (context) => const SmallBusiness(),
        '/Clothes': (context) => const Clothes(),
        '/Blood': (context) => const Blood(),
        '/MedicalBed': (context) => const MedicalBed(),
        '/WheelChair': (context) => const WheelChair(),
        '/TreeDonation': (context) => const TreeDonation(),
        '/DaigDonation': (context) => const DaigDonation(),
        '/MealDonation': (context) => const MealDonation(),
        '/OrphanSupport': (context) => const OrphanSupport(),
        '/WaterCooler': (context) => const WaterCooler(),
        '/MasjidConst': (context) => const MasjidConst(),
        '/Other': (context) => const Other(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFC3BEBE),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF33A248), Color(0xFFB2EA50)],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
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
          height: height,
          width: screenWidth,
          child: const CategoryGrid(),
        ),
      ),
    );
  }
}

class CategoryGrid extends StatefulWidget {
  const CategoryGrid({super.key});

  @override
  _CategoryGridState createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  late Future<List<AllCategoryModel>> categories;

  @override
  void initState() {
    super.initState();
    categories = fetchCategories();
  }

  // Fetch categories from API
  Future<List<AllCategoryModel>> fetchCategories() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/data/categories/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => AllCategoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth < 600) ? 3 : (screenWidth < 900) ? 4 : 5;
    double childAspectRatio = (screenWidth < 400) ? 2 / 3.5 : 3 / 4;

    return FutureBuilder<List<AllCategoryModel>>(
      future: categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Failed to load categories'));
        }

        final categoryList = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              final category = categoryList[index];
              return CategoryTile(
                category: category,
                onSelectCategory: () {
                  Navigator.pushNamed(context, category.route);
                },
              );
            },
          ),
        );
      },
    );
  }
}

class CategoryTile extends StatelessWidget {
  const CategoryTile({
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
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFFFDFBFB),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category.title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage("http://127.0.0.1:8000/data${category.image}"),
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
