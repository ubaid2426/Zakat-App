import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:sadqahzakat/Screens/Islam/widgets/comming_soon_dialog.dart';
import 'package:sadqahzakat/Screens/Islam/widgets/prayer_timing.dart';
const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

class KiblatCard extends StatefulWidget {
  const KiblatCard({super.key});

  @override
  State<KiblatCard> createState() => _KiblatCardState();
}

class _KiblatCardState extends State<KiblatCard> {
  double? latitude;
  String? cityName;
  double? longitude;
  void initState() {
    super.initState();
    _initializeLocation();
    // const QiblaApp();
  }
  Future<void> _initializeLocation() async {
    await readPositionFromStorage();
    if (latitude != null && longitude != null) {
      // If we successfully read latitude and longitude
      cityName = await getCityName(latitude!, longitude!);
      setState(() {}); // Update the UI after getting the city name
    }
  }
  Future<void> readPositionFromStorage() async {
    String? latStr = await _secureStorage.read(key: 'latitude');
    String? longStr = await _secureStorage.read(key: 'longitude');

    latitude = latStr != null ? double.tryParse(latStr) : null;
    longitude = longStr != null ? double.tryParse(longStr) : null;
     cityName = await getCityName(latitude!, longitude!);
  }

  Future<String> getCityName(double latitude, double longitude) async {
    try {
      // Get the list of placemarks from the latitude and longitude
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      // Get the city from the placemarks
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        return placemark.locality ?? 'Unknown city';
      } else {
        return 'City not found';
      }
    } catch (e) {
      print('Error occurred: $e');
      return 'Error getting city name';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16), // Fixed border radius
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 3,
          sigmaY: 3,
        ),
        child: Container(
          padding: const EdgeInsets.all(16), // Fixed padding
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.85),
            borderRadius: BorderRadius.circular(16), // Fixed border radius
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8), // Fixed radius
                    child: Image.asset(
                      'Assests/images/screen1/10001.png',
                      width: screenWidth * 0.1, // Approx. 10% of screen width
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.02, // Approx. 2% of screen width
                  ),
                  Expanded(
                    child: Text(
                      'Taqwa Tracker',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  GestureDetector(
                    key: GlobalKey(),
                    onTap: () {},
                    child: SvgPicture.asset(
                      'assets/images/home_icon/svg/noti.svg',
                      width: screenWidth * 0.06, // Approx. 6% of screen width
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                ],
              ),
              const Divider(),
              GestureDetector(
                key: GlobalKey(),
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     const Text(
                      'Current Location',
                      style:  TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none,
                        fontFamily: "Roboto",
                        color: Color(0xFF7fc23a),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (context) => const ComingSoonDialog(),
                        // );
                      },
                      child:  Text(cityName ?? 'Loading...'),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const PrayerTimingWidget(),
                  GestureDetector(
                    key: GlobalKey(),
                    onTap: () {
                      // Navigator.of(context).pushNamed(RouteGenerator.qibla);
                    },
                    child: SvgPicture.asset(
                      'assets/images/home_icon/svg/kiblat.svg',
                      width: screenWidth * 0.15, // Approx. 15% of screen width
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
