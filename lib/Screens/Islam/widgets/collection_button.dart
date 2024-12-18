import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sadqahzakat/Screens/Islam/Screens/Quran/quran_main.dart';
import 'package:sadqahzakat/Screens/Islam/Screens/Quran/widgets/hadith_main.dart';
import 'package:sadqahzakat/Screens/Islam/Screens/Quran/widgets/name_allah.dart';
import 'package:sadqahzakat/Screens/Islam/models/collections.dart';
import 'package:sadqahzakat/Screens/Islam/widgets/comming_soon_dialog.dart';
import 'package:sadqahzakat/Screens/Islam/widgets/prayer_timing_screen.dart';

// import '../../utils/coming_soon_dialog.dart';
// import '../model/collection.dart';

class CollectionButton extends StatelessWidget {
  const CollectionButton(this.collection, {super.key});

  final Collection collection;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (collection.routeName == 'Coming Soon') {
          showDialog(
            context: context,
            builder: (context) => const ComingSoonDialog(),
          );
          return;
        }
if (collection.routeName != '') {
  // Check the value of collection.routeName
  if (collection.routeName == 'QuranMain') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QuranMain(), // Navigate to QuranMain screen
      ),
    );
  } else if (collection.routeName == 'NameAllahScreen') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NameAllahScreen(), // Navigate to NameAllahScreen
      ),
    );
  }
   else if (collection.routeName == 'HadithMain') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HadithMain(),
      ),
    );
  }
  // else if (collection.routeName == 'QiblaScreen') {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) =>  QiblahScreen() ,
  //     ),
  //   );
  // }
  else if (collection.routeName == 'PrayerTimingScreen') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>const PrayerTimingScreen(), // Navigate to NameAllahScreen
      ),
    );
  } else {
    // If the routeName is something else, you can print or handle it
    print('Unknown route: ${collection.routeName}');
  }
}
      },
      child: Column(
        children: [
          SvgPicture.asset(
            collection.assetName,
            width: 64.w,
          ),
          SizedBox(
            width: 64.w,
            child: Text(
              collection.title,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
