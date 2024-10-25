// import 'package:flutter/material.dart';
// import 'package:zakat_app/components/donate.dart';
// import 'package:zakat_app/core/app_dummy.dart';

// class MarriageSupport extends StatelessWidget {
//   const MarriageSupport({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFF33A248), // First color (#33A248)
//                 Color(0xFFB2EA50), // Second color (#B2EA50)
//               ],
//               begin: Alignment.topRight,
//               end: Alignment.topLeft,
//             ),
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: const Text("Marriage Support"),
//       ),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: marriagesupport.map((donation) {
//               return Data(
//                 imageUrl: donation.imageUrl,
//                 title: donation.title,
//                 description: donation.description,
//                 projectvalue: donation.projectvalue,
//                 paidvlaue: donation.paidvlaue,
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }