import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sadqahzakat/components/custom_button.dart';
// import 'package:zakat_app/components/custom_button.dart';

class ZakatCalculator extends StatefulWidget {
  const ZakatCalculator({super.key});

  @override
  _ZakatCalculatorState createState() => _ZakatCalculatorState();
}

class _ZakatCalculatorState extends State<ZakatCalculator> {
  // Controllers for text fields to get user input
  final TextEditingController cashController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController goldController = TextEditingController();
  final TextEditingController silverController = TextEditingController();

  // Variables to store calculated results
  double subtotal = 0.0;
  double zakatAmount = 0.0;
  double remainingBalance = 0.0;

  // Function to calculate subtotal, zakat and remaining balance
  void calculate() {
    double cash = double.tryParse(cashController.text) ?? 0.0;
    double bank = double.tryParse(bankController.text) ?? 0.0;
    double gold = double.tryParse(goldController.text) ?? 0.0;
    double silver = double.tryParse(silverController.text) ?? 0.0;

    // Calculate the subtotal
    subtotal = cash + bank + gold + silver;

    // Calculate 2.5% Zakat
    zakatAmount = subtotal * 0.025;

    // Calculate remaining balance
    remainingBalance = subtotal - zakatAmount;

    setState(() {}); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zakat Calculator'),
             flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF33A248), // First color (#33A248)
                  Color(0xFFB2EA50), // Second color (#B2EA50)
                ],
                begin: Alignment
                    .bottomRight, // Start the gradient from bottom-right
                end: Alignment.topLeft, // End the gradient at top-left
              ),
            ),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: cashController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Cash',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bankController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Bank Balance',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: goldController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Gold Price',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: silverController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Silver Price',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child:CustomButton(title: "Calculate", icon: FontAwesomeIcons.calculator, onNavigate: calculate)
           
            ),
            const SizedBox(height: 24),
            // Display the results
            Text(
              'Subtotal: \$${subtotal.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              '2.5% Zakat: \$${zakatAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            // Text(
            //   'Remaining Balance: \$${remainingBalance.toStringAsFixed(2)}',
            //   style: const TextStyle(fontSize: 18),
            // ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ZakatCalculator(),
  ));
}
