// import 'package:flutter/material.dart';

// class Category extends StatelessWidget {
//   const Category({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Center(
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 10,
//             childAspectRatio: 2 / 3.4, // Aspect ratio for the grid items
//           ),
//           itemCount: availableCategories.length, // Dynamic item count
//           itemBuilder: (context, index) {
//             final category = availableCategories[index];
//             return Show(
//               category: category,
//               onSelectCategory: () {
//                 Navigator.pushNamed(context, category.route);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
