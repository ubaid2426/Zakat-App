// import 'package:flutter/material.dart';
// import 'package:location/location.dart';

// void main() {
//   runApp(LocationApp());
// }

// class LocationApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LocationScreen(),
//     );
//   }
// }

// class LocationScreen extends StatefulWidget {
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   TextEditingController _latitudeController = TextEditingController();
//   TextEditingController _longitudeController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }

//   Future<void> _getLocation() async {
//     Location location = Location();

//     bool serviceEnabled;
//     PermissionStatus permissionGranted;
//     LocationData locationData;

//     // Check if location services are enabled
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }

//     // Check for location permission
//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     // Get the location
//     locationData = await location.getLocation();

//     setState(() {
//       _latitudeController.text = locationData.latitude?.toString() ?? "N/A";
//       _longitudeController.text = locationData.longitude?.toString() ?? "N/A";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location Viewer'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _latitudeController,
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText: "Latitude",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _longitudeController,
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText: "Longitude",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
