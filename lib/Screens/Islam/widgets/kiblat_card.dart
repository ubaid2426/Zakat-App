import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zakat_app/Screens/Islam/widgets/comming_soon_dialog.dart';
import 'package:zakat_app/Screens/Islam/widgets/prayer_timing.dart';
// import 'package:zakat_app/Screens/Login/components/colors.dart';

class KiblatCard extends StatelessWidget {
  const KiblatCard({super.key});

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
                    child: SvgPicture.asset(
                      'assets/images/core/svg/app_logo.svg',
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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none,
                        fontFamily: "Roboto",
                        color: Color(0xFF7fc23a),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const ComingSoonDialog(),
                        );
                      },
                      child: const Text('Change Location'),
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
