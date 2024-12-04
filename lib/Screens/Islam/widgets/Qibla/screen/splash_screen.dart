// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:zakat_app/Screens/Islam/widgets/Qibla/qibla_screen.dart';
// // import 'package:qibla_finder/Screens/qiblah_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//       const Duration(seconds: 1),
//       () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: ((context) => const QiblahScreen()),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding:
//                 EdgeInsets.only(top: 200, bottom: 100, left: 50, right: 50),
//             child: Center(
//               child: Image(
//                 image: AssetImage('assets/images/qiblat_icon/svg/kiblat_lingkar.png'),
//                 // color: Colors.blueGrey,
//               ),
//             ),
//           ),
//           Text(
//             'Welcome To Qibla Finder App',
//             style: TextStyle(
//               fontSize: 20,
//               fontStyle: FontStyle.italic,
//               fontWeight: FontWeight.bold,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }