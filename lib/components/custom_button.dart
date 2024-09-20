import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:zakat_app/controller/FoodController.dart';
import 'package:zakat_app/controller/controller.dart';
// import 'package:zakat_app/model/donate_model.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton extends StatefulWidget {
    final String title;
  final IconData icon;
  final Widget navigateTo;
  const CustomButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.navigateTo});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isSelected = false;
    final FoodController controller = Get.put(FoodController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
          setState(() {
                    isSelected = !isSelected;
                  });
      },
      onTap: () {
         setState(() {
                    isSelected = !isSelected;
                  });
             Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => widget.navigateTo), // Navigate to the screen
        );
                },
      splashColor: Color(0xFF7fc23a),
      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Color(0xFF7fc23a),
          border: Border.all(color: Color(0xFF7fc23a)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
                color: isSelected ? Colors.black : Colors.white,
              ),
            ),
            Icon(
              widget.icon,
              color: isSelected ? Colors.black : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
