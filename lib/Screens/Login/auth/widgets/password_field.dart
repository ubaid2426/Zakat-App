
import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/Login/components/colors.dart';
// import 'package:zakat_app/Screens/Login/components/colors.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController password;
  const PasswordField({super.key, required this.password});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool secure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.password,
      validator: (value) {
        if (value!.length < 4) {
          return "the password is too weak";
        } else {
          return null;
        }
      },
      obscureText: secure == true ? true : false,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              secure = !secure;
            });
          },
          child: Icon(
            secure == true ? Icons.visibility_off : Icons.visibility_outlined,
            color: MyColors().maincolor,
          ),
        ),
        label: Text(
          'Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColors().maincolor,
          ),
        ),
      ),
    );
  }
}
