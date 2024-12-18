import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/Islam/widgets/appbar_expanded.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:zakat_app/Screens/Islam/widgets/appbar_expanded.dart';
// import 'appbar_expanded.dart'; // Ensure AppBarExpanded is defined properly

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,
      // centerTitle: false,
      // titleSpacing: 16, // Fixed spacing
      // title: AnimatedSwitcher(
      //   duration: const Duration(milliseconds: 300),
      //   switchInCurve: Curves.easeIn,
      //   reverseDuration: Duration.zero,
      //   child: Text(
      //     'Sirate Mustaqeem',
      //     style: Theme.of(context).textTheme.headlineSmall,
      //   ),
      // ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 16),
      //     child: GestureDetector(
      //       onTap: () {
      //         // Action on tap
      //       },
      //       child: SvgPicture.asset(
      //         'assets/images/home_icon/svg/noti.svg', // Ensure this path is correct
      //         width: 24, // Fixed width
      //         color: Theme.of(context).textTheme.bodyMedium?.color,
      //       ),
      //     ),
      //   ),
      // ],
      elevation: 0, // No elevation for a flat look
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(30), // Height of the expanded area
        //  child: Container(color: Colors.red),
        child: Builder(
          builder: (context) {
            try {
              //  return Container(color: Colors.red,);
              return const Expanded(child: AppBarExpanded()); // Replace with your actual expanded content widget
            } catch (e, stackTrace) {
              debugPrint("Error in AppBarExpanded: $e\n$stackTrace");
              return Container(color: Colors.red); // Fallback in case of error
            }
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(30); // Adjust for total height
}


// class HomeAppBar extends StatelessWidget {
//   const HomeAppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(color: Colors.red, height: 100,);
//   }
// }