// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class LocationScreen extends StatefulWidget {
//   final double latitude;
//   final double longitude;
//   // final String address;

//   LocationScreen({
//     required this.latitude,
//     required this.longitude,
//     // required this.address,
//   });

//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   late GoogleMapController mapController;

//   late CameraPosition _initialCameraPosition;
//   late LatLng _location;

//   @override
//   void initState() {
//     super.initState();
//     _location = LatLng(widget.latitude, widget.longitude);
//     _initialCameraPosition = CameraPosition(
//       target: _location,
//       zoom: 14,
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location Details'),
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue, Colors.green],
//               begin: Alignment.bottomRight,
//               end: Alignment.topLeft,
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Padding(
//           //   padding: const EdgeInsets.all(8.0),
//           //   child: Text(
//           //     widget.address,
//           //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           //   ),
//           // ),
//           Container(
//             height: 400,
//             width: double.infinity,
//             child: GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: _initialCameraPosition,
//               markers: {
//                 Marker(
//                   markerId: MarkerId('location'),
//                   position: _location,
//                   // infoWindow: InfoWindow(title: widget.address),
//                 ),
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
