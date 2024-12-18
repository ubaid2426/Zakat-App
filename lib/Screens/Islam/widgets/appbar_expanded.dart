import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sadqahzakat/Screens/Islam/widgets/kiblat_card.dart';
// import 'package:zakat_app/Screens/Islam/widgets/kiblat_card.dart';

class AppBarExpanded extends StatelessWidget {
  const AppBarExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Get the current theme's brightness directly from the context
    final brightness = Theme.of(context).brightness;

    return SizedBox(
      width: screenWidth,
      height: screenHeight * 0.4,
      child: Stack(
        children: [
          // Display the appropriate SVG based on the current theme
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.4,
            child: brightness == Brightness.dark
                ? SvgPicture.asset(
                    'assets/images/home_icon/svg/night_mode.svg',
                    fit: BoxFit.cover,
                  )
                : SvgPicture.asset(
                    'assets/images/home_icon/svg/day_mode.svg',
                    fit: BoxFit.cover,
                  ),
          ),
          Container(
            width: screenWidth,
            height: screenHeight * 0.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.5),
                  Colors.transparent,
                ],
                stops: const [0.2, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Assalamu alaikum',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                    Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, // Dynamic padding
                  ),
                  child: const KiblatCard(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
