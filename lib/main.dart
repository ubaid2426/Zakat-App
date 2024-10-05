import 'package:flutter/material.dart';
import 'package:zakat_app/components/navigation.dart';

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
        body: Navigation(),
      ),
    );
  }
}









// import 'package:currency_converter/currency.dart';
// import 'package:currency_converter/currency_converter.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   //def variable
//   String? usdToInr;

//   @override
//   void initState() {
//     super.initState();
// // add in initState
//     convert();
//   }

// // call function to convert
//   void convert() async {
//     Currency myCurrency = await CurrencyConverter.getMyCurrency();
//     var usdConvert = await CurrencyConverter.convert(
//       from: Currency.pkr,
//       to: myCurrency,
//       amount: 1,
//       withoutRounding: true,
//     );
//     setState(() {
//       usdToPkr = usdConvert.toString();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Money Convertor Example'),
//           centerTitle: true,
//         ),
//         body: Container(
//           padding: const EdgeInsets.all(20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Text(
//                 "1 USD = ",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Expanded(
//                 child: Text(
//                   "$usdToInr ${Currency.aed.name.toUpperCase()}",
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                     color: Colors.green,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }