import 'package:flutter/material.dart';
import 'package:zakat_app/components/donate.dart';
import 'package:zakat_app/core/app_dummy.dart';

class Clothes extends StatelessWidget {
  const Clothes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF33A248), // First color (#33A248)
                Color(0xFFB2EA50), // Second color (#B2EA50)
              ],
              begin: Alignment.topRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Clothes Donation"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Checking if the `clothes` list is not empty
              if (clothes.isNotEmpty)
                Column(
                  children: clothes.map((donation) {
                    return Data(
                      imageUrl: donation.imageUrl,
                      title: donation.title,
                      description: donation.description,
                      projectvalue: donation.projectvalue,
                      paidvlaue: donation.paidvlaue,
                    );
                  }).toList(),
                )
              else
                // Show message if `clothes` list is empty
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "This domain does not need donations at the moment.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
