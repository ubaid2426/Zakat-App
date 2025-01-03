
import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/Login/components/colors.dart';
// import 'package:zakat_app/Screens/Login/components/colors.dart';

class FullNameField extends StatelessWidget {
  final TextEditingController name;
  const FullNameField({super.key,required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.09,
      child: TextFormField(
        validator: (value) {
          if (value!.length < 3) {
            return "invalid name";
          } else {
            return null;
          }
        },
        controller: name,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.check,
            color: MyColors().maincolor,
          ),
          label: Text(
            'Full name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors().maincolor,
            ),
          ),
        ),
      ),
    );
  }
}
