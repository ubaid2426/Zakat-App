import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/Islam/widgets/hadess_card.dart';
// import 'package:sizer/sizer.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:zakat_app/Screens/Islam/widgets/hadess_card.dart';

import 'ayat_card.dart';
import 'collection_card.dart';
import 'random_image_card.dart';

class HomeSliverList extends StatelessWidget {
  const HomeSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255), // Set your desired background color here
      child:const Column(
        children: [
          CollectionCard(),
          SizedBox(
            // height: 16.h,
            height: 12,
          ),
           AyatCard(),
          SizedBox(
            // height: 16.h,
            height: 12,
          ),
          HadessCard(),
          SizedBox(
            // height: 16.h,
            height: 12,
          ),
          RandomImageCard(),
          SizedBox(
            // height: 112.h,
            height: 12,
          ),
        ],
      ),
    );
  }
}
