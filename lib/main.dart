import 'package:flutter/material.dart';
import 'package:zakat_app/components/navigation.dart';
// import 'package:zakat_app/components/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Color.fromARGB(255, 215, 212, 212),
        body: Navigation(),
      ),
    );
  }
}

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text1(),
//                 Text1(),
//                 Text1(),
//               ],
//             ),
//             Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text1(),
//                 Text1(),
//                 Text1(),
//               ],
//             ),
//             Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text1(),
//                 Text1(),
//                 Text1(),
//               ],
//             ),
//             Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text1(),
//                 Text1(),
//                 Text1(),
//               ],
//             ),
//             Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text1(),
//                 Text1(),
//                 Text1(),
//               ],
//             ),
//             Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text1(),
//                 Text1(),
//                 Text1(),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Text1 extends StatelessWidget {
//   const Text1({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
//       child: Row(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: const Color.fromARGB(255, 253, 251, 251),
//             ),
//             height: 200,
//             width: MediaQuery.of(context).size.width / 3 - 19,
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 4,
//                 ),
//                 Text(
//                   'Masjid Maintenance',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//                 // SizedBox(height: 20,),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 245, 188,
//                         2), // Optional, for background color if the image doesn't cover
//                     borderRadius: BorderRadius.circular(15),
//                     image: DecorationImage(
//                       image: AssetImage(
//                           "Assests/images/AllCategory/medicalbed.png"),
//                       fit: BoxFit
//                           .cover, // To ensure the image covers the entire container
//                     ),
//                   ),
//                   width: 120,
//                   height: 150,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
