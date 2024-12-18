import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/Login/components/colors.dart';
// import 'package:zakat_app/Screens/Login/components/colors.dart';


class SiratCard extends StatelessWidget {
  const SiratCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: kPagePadding,
      padding: kCardPadding,
      decoration: BoxDecoration(
        borderRadius: kCardBorderRadius,
        color: Theme.of(context).colorScheme.surface,
      ),
      child: child,
    );
  }
}
