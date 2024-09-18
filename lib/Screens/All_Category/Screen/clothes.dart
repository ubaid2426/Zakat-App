import 'package:flutter/material.dart';
import 'package:zakat_app/components/donate.dart';

class Clothes extends StatelessWidget {
  const Clothes({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Data(
              imageUrl: "Assests/images/AllCategory/wheelchair.png",
              title: "Wheelchair Donation",
              description:
                  "Donate wheelchairs to enhance mobility and independence for individuals in need. Your contribution can significantly improve their quality of life."),
        ],
      ),
    );
  }
}
