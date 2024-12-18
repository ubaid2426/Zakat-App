import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/History/history_main.dart';
// import 'package:zakat_app/Screens/History/history_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyDonation(),
    );
  }
}

class MyDonation extends StatefulWidget {
  const MyDonation({super.key});

  @override
  _MyDonationState createState() => _MyDonationState();
}

class _MyDonationState extends State<MyDonation> {
  double donationAmount = 0.0;

  // Function to simulate donation
  void addDonation(double amount) {
    setState(() {
      donationAmount += amount;
    });
  }

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
        title: const Text('Donation Tracker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Circular Progress based on donation
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: donationAmount > 0
                        ? 1.0
                        : 0.0, // Fill when donation > 0
                    strokeWidth: 20,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      donationAmount > 0
                          ? Colors.green
                          : Colors.grey, // Color based on donation amount
                    ),
                    backgroundColor:
                        Colors.grey[300], // Background color when empty
                  ),
                ),
                // Text showing the donation amount
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$${donationAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Donated',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Button to view donation history
          ElevatedButton(
            onPressed: () {
              // Add functionality to view donation history
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DonationHistory()), // Navigate to the screen
              );
            },
            style: ElevatedButton.styleFrom(
              // primary: Colors.yellow, // Background color
              // onPrimary: Colors.black, // Text color
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            child: const Text(
              'VIEW DONATION HISTORY',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          // Button to simulate adding a donation
          // ElevatedButton(
          //   onPressed: () {
          //     addDonation(10.0); // Simulate adding a $10 donation
          //   },
          //   child: const Text('Add Donation'),
          // ),
        ],
      ),
    );
  }
}
