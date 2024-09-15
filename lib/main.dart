import 'package:flutter/material.dart';
import 'package:zakat_app/Widgets/drawers_main.dart';
import 'package:zakat_app/components/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData().copyWith(
      //   scaffoldBackgroundColor: const Color(0xFF29C77B),
      // ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Column(
        //     children: [
        //       // const Text("Sadqahzakat"),
        //       Image.asset(
        //         'Assests/images/screen1/10001.png', // Replace with your image path
        //         fit: BoxFit.contain,
        //         height: 200,
        //         width: 200, // Adjust the height as per your requirement
        //       ),
        //       const SizedBox(width: 10), // Spacing between image and text
        //       // You can add a title next to the image
        //     ],
        //   ),
        // ),
        // drawer: const MainDrawer(),
        body: Navigation(),
      ),
    );
  }
}
