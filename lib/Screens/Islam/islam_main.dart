import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qibla_direction/qibla_direction.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:sadqahzakat/Screens/Islam/widgets/appbar_expanded.dart';
import 'package:sadqahzakat/Screens/Islam/widgets/home_silver_llist.dart';

const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

class IslamScreen extends StatefulWidget {
  const IslamScreen({super.key});

  @override
  State<IslamScreen> createState() => _IslamScreenState();
}

class _IslamScreenState extends State<IslamScreen> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  StreamSubscription<Position>? _positionStreamSubscription;
  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<void> writePositionToStorage(double latitude, double longitude) async {
    await _secureStorage.write(key: 'latitude', value: latitude.toString());
    await _secureStorage.write(key: 'longitude', value: longitude.toString());
  }

  /// Fetches the current position and calculates the Qibla direction and distance.
  Future<void> _getCurrentPosition() async {
    if (!await _handlePermission()) return;

    final position = await _geolocatorPlatform.getCurrentPosition();
    setState(() {
      final coordinate = Coordinate(position.latitude, position.longitude);
      writePositionToStorage(position.latitude, position.longitude);
      // debugPrint(position.latitude as String?);
      // print(_currentPosition);
    });
  }

  /// Handles location permissions.
  Future<bool> _handlePermission() async {
    if (!await _geolocatorPlatform.isLocationServiceEnabled()) {
      _showErrorDialog('Location services are disabled.');
      return false;
    }

    var permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        _showErrorDialog('Location permission denied.');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showErrorDialog('Location permission denied forever.');
      return false;
    }

    return true;
  }

  /// Shows an error dialog.
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      // height: 300,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          AppBarExpanded(),
          HomeSliverList(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }
}
