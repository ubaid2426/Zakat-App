import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sadqahzakat/controller/controller.dart';
// import 'package:zakat_app/controller/controller.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget? navigateTo;
  final Function? onNavigate; // Function to call if not navigating to a Widget

  const CustomButton( {
    super.key,
    required this.title,
    required this.icon,
    this.navigateTo,
    this.onNavigate,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isPressed = false; // Track if the button is currently pressed
  final FoodController controller = Get.put(FoodController());

  void _handleTap() {
    if (widget.navigateTo != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget.navigateTo!),
      );
    } else if (widget.onNavigate != null) {
      widget.onNavigate!(); // Call the provided function if no navigation widget
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTapDown: (_) {
          setState(() {
            isPressed = true; // Set isPressed to true when the button is pressed
          });
        },
        onTapUp: (_) {
          setState(() {
            isPressed = false; // Set isPressed to false when the button is released
          });
          _handleTap(); // Handle navigation
        },
        onTapCancel: () {
          setState(() {
            isPressed = false; // Reset if the tap is canceled
          });
        },
        splashColor: const Color(0xFF7fc23a),
        child: Container(
          width: MediaQuery.of(context).size.width /2 -40,
          height: 60,
          decoration: BoxDecoration(
            color: isPressed ? const Color(0xFF7fc23a) : Colors.white, // Change color based on isPressed
            border: Border.all(color: const Color(0xFF7fc23a)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(
                widget.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isPressed ? Colors.white : const Color(0xFF7fc23a), // Change text color
                ),
              ),
              Icon(
                widget.icon,
                size: 16,
                color: isPressed ? Colors.white : const Color(0xFF7fc23a), // Change icon color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
