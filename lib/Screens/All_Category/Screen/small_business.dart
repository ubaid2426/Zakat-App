import 'package:flutter/material.dart';
import 'package:zakat_app/components/donate_special.dart';

class SmallBusiness extends StatelessWidget {
  const SmallBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: const DataSpecial(
          imageUrl: "Assests/images/AllCategory/clothes.png",
          title: "Check",
          description: "THis is your checking",
          projectvalue: 1000,
          paidvlaue: 0),
    );
  }
}
