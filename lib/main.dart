import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:zakat_app/Screens/Islam/islam_main.dart';
import 'package:zakat_app/components/navigation.dart';
// import 'package:zakat_app/components/navigation.dart';

void main() {
// debugPrint(widget.toStringDeep());
  runApp(

    ScreenUtilInit(
      designSize: const Size(330, 812), // Use ScreenUtil's designSize
      minTextAdapt: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Navigation(),
      ),
    );
  }
}
