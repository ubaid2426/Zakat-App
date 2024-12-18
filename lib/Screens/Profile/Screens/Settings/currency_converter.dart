import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sadqahzakat/components/custom_button.dart';
// import 'package:zakat_app/components/custom_button.dart';

void main() {
  runApp(const CurrencyConverterScreen());
}

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String? result;

  // List of currencies for the dropdown
  final List<Currency> currencies = [
    Currency.usd,
    Currency.inr,
    Currency.aed,
    Currency.pkr,
    Currency.eur,
    Currency.gbp,
    Currency.kwd,
  ];

  Currency? fromCurrency = Currency.usd;
  Currency? toCurrency = Currency.inr;

  // Text controller for the amount input
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // Function to handle the conversion
  void convert() async {
    if (fromCurrency != null &&
        toCurrency != null &&
        amountController.text.isNotEmpty) {
      double amount = double.parse(amountController.text);
      var convertedAmount = await CurrencyConverter.convert(
        from: fromCurrency!,
        to: toCurrency!,
        amount: amount,
        withoutRounding: true,
      );
      setState(() {
        result = convertedAmount.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
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
          title: const Text(
            "Currency Converter",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              fontFamily: "Roboto",
            ),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Dropdown for "from" currency
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("From: "),
                  const SizedBox(width: 10),
                  DropdownButton<Currency>(
                    value: fromCurrency,
                    onChanged: (Currency? newValue) {
                      setState(() {
                        fromCurrency = newValue;
                      });
                    },
                    items: currencies
                        .map<DropdownMenuItem<Currency>>((Currency value) {
                      return DropdownMenuItem<Currency>(
                        value: value,
                        child: Text(value.name.toUpperCase()),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Dropdown for "to" currency
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("To: "),
                  const SizedBox(width: 10),
                  DropdownButton<Currency>(
                    value: toCurrency,
                    onChanged: (Currency? newValue) {
                      setState(() {
                        toCurrency = newValue;
                      });
                    },
                    items: currencies
                        .map<DropdownMenuItem<Currency>>((Currency value) {
                      return DropdownMenuItem<Currency>(
                        value: value,
                        child: Text(value.name.toUpperCase()),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // ElevatedButton(
              //   onPressed: convert,
              //   child: const Text("Convert"),
              // ),
              CustomButton(title: "Convert", icon: FontAwesomeIcons.coins, onNavigate: convert,),
              const SizedBox(height: 30),
              // Display the result
              if (result != null)
                Text(
                  "Converted Amount: $result ${toCurrency?.name.toUpperCase()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.green,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
