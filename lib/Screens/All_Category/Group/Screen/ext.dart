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













  // Widget buildDonationSection() {
  //   double progress = paidValue / projectValue;

  //   if (progress >= 1.0) {
  //     return const Padding(
  //       padding: EdgeInsets.all(20.0),
  //       child: CustomButton(
  //         title: "Donation Complete",
  //         icon: FontAwesomeIcons.checkDouble,
  //       ),
  //     );
  //   }

  //   return Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: Column(
  //       children: [
  //         const Text(
  //           "Enter Donation Amount (\$)",
  //           style: TextStyle(
  //             fontSize: 18.0,
  //             decoration: TextDecoration.none,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         const SizedBox(height: 20.0),
  //         GetBuilder<FoodController>(
  //           builder: (foodController) {
  //             return CounterButton(
  //               onIncrementSelected: () => foodController.increaseDonation(),
  //               onDecrementSelected: () => foodController.decreaseDonation(),
  //               label: Text(
  //                 foodController.donationAmount.toString(),
  //                 style: Theme.of(context).textTheme.displayLarge,
  //               ),
  //             );
  //           },
  //         ),
  //         const SizedBox(height: 30.0),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             const CustomButton(
  //               title: "Donate",
  //               icon: FontAwesomeIcons.circleDollarToSlot,
  //               navigateTo: PaymentMethod(),
  //             ),
  //             buildAddToCartButton(),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }