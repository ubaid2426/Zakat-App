import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart'; // Use this or Sizer
import 'package:zakat_app/Screens/Islam/utils/appbar_bloc/appbar_bloc.dart';
import 'package:zakat_app/Screens/Islam/widgets/appbar_expanded.dart';
import 'package:zakat_app/Screens/Islam/widgets/home_silver_llist.dart';
import 'package:zakat_app/Screens/Islam/widgets/home_silver_appbar.dart';


class IslamScreen extends StatefulWidget {
  const IslamScreen({super.key});

  @override
  State<IslamScreen> createState() => _IslamScreenState();
}

class _IslamScreenState extends State<IslamScreen> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return 
   const SingleChildScrollView(
      // height: 300,
      child:  Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          AppBarExpanded(),
          HomeSliverList(),
        ],
      ),
    );
    // CustomScrollView(
    //   controller: controller,
    //   keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    //   slivers: const [
    //     // HomeSliverAppbar(),
    //     HomeSliverList(),
    //   ],
    // );
  }
}
