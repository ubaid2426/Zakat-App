import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sadqahzakat/components/Help.dart';
// import 'package:zakat_app/Screens/All_Category/all_category.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/all_category.dart';
// import 'package:zakat_app/components/Help.dart';
// import 'package:zakat_app/components/upcoming_project.dart';

class HelpChild extends StatelessWidget {
  const HelpChild({super.key, required this.image});
  final ImageProvider image;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: Scaffold(
        home: SafeArea(
          child: InkWell(
            onTap: () {
            //  Navigator.push(context, MaterialPageRoute(builder: (context) => AllCategory()));
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Stack(
                  children: [
                    Help(image: image),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      width: 100,
                      height: 50,
                      child: SizedBox(
                        width: 100,
                        height: 150,
                        child: Stack(
                          children: [
                            Icon(
                              FontAwesomeIcons.arrowUpRightDots,
                              size: 45,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // ),
      );
}

class HelpText extends StatelessWidget {
  const HelpText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Help Children rise out of the poverty");
  }
}
