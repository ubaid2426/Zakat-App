// import 'package:flutter/material.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/clothes.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/daig_donation.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/food_relief.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/marriage_support.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/masjid_const.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/masjid_maintenance.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/meal_donation.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/medical_bed.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/orphan_support.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/other.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/portable_house.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/small_business.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/tree_donation.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/water_cooler.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/wheel_chair.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/widow_family.dart';
// import 'package:zakat_app/core/app_dummy.dart';
// import 'package:zakat_app/model/all_category.dart';

// class AllCategory extends StatelessWidget {
//   const AllCategory({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//             routes: {
//         '/PortableHouse': (context) => const PortableHouse(),
//         '/MasjidMaintenance': (context) => const MasjidMaintenance(),
//         '/MarriageSupport': (context) => const MarriageSupport(),
//         '/FloodRelief': (context) => const FloodRelief(),
//         '/WidowFamily': (context) => const WidowFamily(),
//         '/SmallBusinessSetup': (context) => const SmallBusiness(),
//         '/Clothes': (context) => const Clothes(),
//         '/MedicalBed': (context) => const MedicalBed(),
//         '/WheelChair': (context) => const WheelChair(),
//         '/TreeDonation': (context) => const TreeDonation(),
//         '/DaigDonation': (context) => const DaigDonation(),
//         '/MealDonation': (context) => const MealDonation(),
//         '/OrphanSupport': (context) => const OrphanSupport(),
//         '/WaterCooler': (context) => const WaterCooler(),
//         '/MasjidConst': (context) => const MasjidConst(),
//         '/Other': (context) => const Other(),
//         // Add more routes as needed for each category
//       },
//       debugShowCheckedModeBanner: false,
//       // home: const Scaffold(
//         home: Category(),
//       // ),
//     );
//   }
// }

// class Show extends StatelessWidget {
//   const Show(
//       {super.key, required this.category, required this.onSelectCategory});
//   // final String title;
//   // final String image;
//   final AllCategoryModel category;
//   final void Function() onSelectCategory;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: InkWell(
//           onTap: onSelectCategory,
//           child: Column(
//             children: [
//               SizedBox(
//                 // width: MediaQuery.of(context).size.width * 0.40,
//                 width: 150,
//                 height: 150,
//                 child: DecoratedBox(
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: const BorderRadius.all(Radius.circular(100)),
//                     image: DecorationImage(
//                       image: AssetImage(category.image), // Adjust the image path
//                       fit: BoxFit.cover, // Adjust the fit as needed
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               SizedBox(
//                 width: 250,
//                 child: Text(
//                   category.title,
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       fontFamily: "Roboto"),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Category extends StatelessWidget {
//   const Category({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width,
//       height: double.infinity,
//       child: GridView(
//         // width: MediaQuery.of(context).size.width,
//         // padding: const EdgeInsets.fromLTRB(20, 15, 25, 20),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           // childAspectRatio: 2 / 3,
//           // width: MediaQuery.of(context).size.width,
//           crossAxisSpacing: 0,
//           mainAxisSpacing: 0,
//         ),
//         children: [
//           // availableCategories.map((category) => CategoryGridItem(category: category)).toList(),
//           for (final category in availableCategories)
//             Show(
//               category: category,
//               onSelectCategory: () {
//                 final selectedCategory = availableCategories
//                     .firstWhere((element) => element.id == category.id);
//                 Navigator.pushNamed(context, selectedCategory.route);
//                 //  final selectedCategory = availableCategories
//                 //       .firstWhere((category) => category.id == category.id);
//                 //   Navigator.pushNamed(context, selectedCategory.route);
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }

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
        appBar: AppBar(
          title: Text(
            "ALL CATEGORY",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontFamily: "Roboto",
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: const Category(),
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
      child: Column(
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                image: DecorationImage(
                  image: AssetImage(category.image), // Image path from model
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 250,
            child: Text(
              category.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: "Roboto",
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        children: [
          for (final category in availableCategories)
            Show(
              category: category,
              onSelectCategory: () {
                Navigator.pushNamed(context, category.route);
              },
            ),
        ],
      ),
    );
  }
}
