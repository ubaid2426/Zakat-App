import 'package:flutter/material.dart';
import 'package:zakat_app/components/donate_special.dart';

class SmallBusiness extends StatelessWidget {
  const SmallBusiness({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF33A248), // First color (#33A248)
                  Color(0xFFB2EA50), // Second color (#B2EA50)
                ],
                begin: Alignment.topRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
        title:const Row(
          children: [
          //    IconButton(
          //   icon: Icon(Icons.shopping_cart),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) =>
          //               Navigation()), // Navigate to the screen
          //     );
          //   },
          // ),
             Text('Small Business Setup', textAlign: TextAlign.center,),
          ],
        ),
           leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body:  SingleChildScrollView(
        child: DataSpecial(
            imageUrl: "Assests/images/AllCategory/clothes.png",
            title: "Check",
            description: "THis is your checking",
            projectvalue: 1000,
            paidvlaue: 0),
      ),
    );
  }
}
