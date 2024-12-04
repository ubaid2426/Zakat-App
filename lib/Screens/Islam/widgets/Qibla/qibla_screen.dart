// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_qiblah/flutter_qiblah.dart';

// class QiblahScreen extends StatefulWidget {
//   const QiblahScreen({super.key});

//   @override
//   State<QiblahScreen> createState() => _QiblahScreenState();
// }

// class _QiblahScreenState extends State<QiblahScreen> with SingleTickerProviderStateMixin {
//   late Animation<double> animation;
//   late AnimationController _animationController;
//   double begin = 0.0;

//   @override
//   void initState() {
//     _animationController =
//         AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
//     animation = Tween(begin: 0.0, end: 0.0).animate(_animationController);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color.fromARGB(255, 48, 48, 48),
//         body: StreamBuilder<QiblahDirection>(
//           stream: FlutterQiblah.qiblahStream,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(color: Colors.white),
//               );
//             }

//             if (!snapshot.hasData) {
//               return const Center(
//                 child: Text(
//                   'Unable to determine Qiblah',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               );
//             }

//             final qiblahDirection = snapshot.data!;
//             final angle = qiblahDirection.qiblah * (pi / 180) * -1;

//             animation = Tween(begin: begin, end: angle).animate(_animationController);
//             begin = angle;
//             _animationController.forward(from: 0);

//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "${qiblahDirection.direction.toInt()}°",
//                     style: const TextStyle(color: Colors.white, fontSize: 24),
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     height: 300,
//                     child: AnimatedBuilder(
//                       animation: animation,
//                       builder: (context, child) => Transform.rotate(
//                         angle: animation.value,
//                         child: Image.asset('assets/images/qibla.png'),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
