import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zakat_app/controller/controller.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget? navigateTo;
  final Function? onNavigate; // Function to call if not navigating to a Widget

  const CustomButton({
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
  bool isSelected = false;
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
    return InkWell(
      onHover: (value) {
        setState(() {
          isSelected = value; // Update selection based on hover
        });
      },
      onTap: () {
        setState(() {
          isSelected = !isSelected; // Toggle selection on tap
        });
        _handleTap(); // Handle navigation
      },
      splashColor: const Color(0xFF7fc23a),
      child: Container(
        width: 190,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFF7fc23a),
          border: Border.all(color: const Color(0xFF7fc23a)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
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
