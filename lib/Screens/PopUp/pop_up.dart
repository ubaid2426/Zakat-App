// import 'package:flutter/material.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/individual_donation.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/request_donation.dart';

// class Pop extends StatefulWidget {
//   const Pop({super.key});

//   @override
//   _PopState createState() => _PopState();
// }

// class _PopState extends State<Pop> {
//   @override
//   void initState() {
//     super.initState();
//     // Show the dialog as soon as the widget is loaded
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _showFoodDialog(context);
//     });
//   }

//   // Method to show the initial dialog with options
//   void _showFoodDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           // content: const Text('Choose your donation option:'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Individual Donation'),
//               onPressed: () {
//              Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>  IndividualDonation(),
//                     ),
//                   );
//               },
//             ),
//             TextButton(
//               child: const Text('Request For Donation'),
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>  RequestDonation(),
//                     ),
//                   );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Method to show the response dialog after a selection
//   // void showResponseDialog(BuildContext context, String response) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: const Text('Response'),
//   //         content: Text(response),
//   //         actions: <Widget>[
//   //           TextButton(
//   //             child: const Text('OK'),
//   //             onPressed: () {
//   //               Navigator.of(context).pop(); // Close response dialog
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
  
//   // @override
//   // Widget build(BuildContext context) {
//   //   // TODO: implement build
//   //   throw UnimplementedError();
//   // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Pop Example'),
// //       ),
// //       body: Center(
// //         child: ElevatedButton(
// //           onPressed: () {
// //             _showFoodDialog(context); // Manually trigger dialog again if needed
// //           },
// //           child: const Text('Show Donation Options'),
// //         ),
// //       ),
// //     );
// //   }
// }
