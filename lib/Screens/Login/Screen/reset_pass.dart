import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:zakat_app/Screens/Login/Screen/NetworkHandler.dart';
import 'dart:convert';

import 'package:zakat_app/components/navigation.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
    NetworkHandler networkHandler = NetworkHandler();
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String errorText = ''; // Initialize errorText to an empty string
  bool validate = false;
  bool circular = false;
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(0.0, 1.0),
            end: FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated,
            colors: [Colors.white, Colors.green], // Provide actual colors
          ),
        ),
        child: Form(
          key: _globalkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 20),
                emailTextField(),
                const SizedBox(height: 15),
                newPasswordTextField(),
                const SizedBox(height: 15),
                confirmPasswordTextField(),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    if (_globalkey.currentState!.validate()) {
                      setState(() {
                        circular = true;
                      });

                      // Retrieve stored UUID and token (you should have this before)
                      String? uuid = await storage.read(key: 'uuid');
                      String? token = await storage.read(key: 'token');

                      if (uuid != null && token != null) {
                        await resetPassword(uuid, token);
                      } else {
                        setState(() {
                          errorText = 'UUID or token not found';
                          validate = true;
                          circular = false;
                        });
                      }
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff00A86B),
                    ),
                    child: Center(
                      child: circular
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Update Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Column(
      children: [
        const Text("Email"),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          },
        )
      ],
    );
  }

  Widget newPasswordTextField() {
    return Column(
      children: [
        const Text("New Password"),
        TextFormField(
          controller: newPasswordController,
          obscureText: vis,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            suffixIcon: IconButton(
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter a new password';
            }
            return null;
          },
        )
      ],
    );
  }

  Widget confirmPasswordTextField() {
    return Column(
      children: [
        const Text("Confirm Password"),
        TextFormField(
          controller: confirmPasswordController,
          obscureText: vis,
          decoration: InputDecoration(
            errorText: validate ? null : errorText,
            suffixIcon: IconButton(
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != newPasswordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        )
      ],
    );
  }

  Future<void> resetPassword(String uuid, String token) async {
    String url = 'http://127.0.0.1:8000/api/auth/users/reset_password_confirm/$uuid/$token/';

    Map<String, String> data = {
      'new_password': newPasswordController.text,
      're_new_password': confirmPasswordController.text,
    };

    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Navigate to a success page or show a success message
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Navigation()),
      );
    } else {
      setState(() {
        errorText = 'Failed to reset password: ${response.body}';
        validate = true;
        circular = false;
      });
    }
  }
}
