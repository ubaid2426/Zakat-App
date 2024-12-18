import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/all_category.dart';
// import 'package:zakat_app/Screens/All_Category/Group/all_category.dart';
// import 'package:zakat_app/Screens/All_Category/all_category.dart';
// import 'package:zakat_app/Screens/All_Category/Screen/all_category.dart';

class FoodDonation extends StatelessWidget {
  const FoodDonation({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const AddPicture(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "We Believe your donation will help to survive people and may Allah reward for Jannah",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Roboto"),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "There is enough food on Earth to feed everyone. Millions are going hungry not because of global inability to grow enough food, although this could chnage as climate related disasters.",
                style: TextStyle(
                  color: Color.fromARGB(255, 63, 62, 62),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 50,),
              ElevatedButton(
                onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const AllCategoryGroup()));},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF29C77B), // Button color
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  "DONATE",
                  style: TextStyle(
                    fontSize: 18.8,
                    fontFamily: "Roboto",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AddPicture extends StatelessWidget {
  const AddPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        TwoBck(),
        Positioned(
          child: Picture(),
        ),
      ],
    );
  }
}

class TwoBck extends StatelessWidget {
  const TwoBck({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft, // Align to the right side
          child: BackgroundImage2(),
        ),
        Positioned(
          top: 30,
          left: 20,
          child: BackgroundImage1(), // Background covers the full screen
        ),
      ],
    );
  }
}

class BackgroundImage1 extends StatelessWidget {
  const BackgroundImage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350, // Fixed width of 350
      height: 500, // Full height of the screen
      color: const Color(0xFF29C77B), // Your color
    );
  }
}

class BackgroundImage2 extends StatelessWidget {
  const BackgroundImage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350, // Full width of the screen
      height: 500, // Full height of the screen
      color: const Color.fromARGB(255, 0, 0, 0), // Black background
    );
  }
}

class Picture extends StatelessWidget {
  const Picture({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 600,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assests/images/screen1/fooddonation.png'),
            fit: BoxFit.contain,
          ),
        ));
  }
}
