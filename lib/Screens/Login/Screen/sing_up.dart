import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:phonenumbers/phonenumbers.dart';
import 'package:sadqahzakat/Screens/Login/Screen/login_page.dart';
import 'package:sadqahzakat/Screens/Login/components/clipper.dart';
import 'package:sadqahzakat/Screens/Login/components/colors.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool secure = true;
  GlobalKey<FormState> signup = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  final phoneNumberController = PhoneNumberEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController whatsapp = TextEditingController();
  TextEditingController residense = TextEditingController();
  TextEditingController nationality = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conpassword = TextEditingController();

  bool isLoading = false;
  String message = '';
  Future<void> _registerUser(String name, String email, String password, String nationality, String whatsapp, String residense, String phonenumber) async {
    var url = Uri.parse(
        // 'https://sadqahzakaat.com/api/auth/users/'); // Replace with your IP
        'https://sadqahzakaat.com/api/auth/users/'); // Replace with your IP

    // Construct the payload
    Map<String, String> payload = {
      'email': email,
      'name': name,
      'nationality':nationality,
      'whatsapp_number':whatsapp,
      'residense':residense,
      'contact_number':phonenumber,
      'password': password,
      're_password': password, // Ensure this matches the API requirements
    };

    try {
      setState(() {
        isLoading = true; // Show loader
      });

      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      setState(() {
        isLoading = false; // Hide loader
      });

      if (response.statusCode == 201) {
        // Registration successful
        setState(() {
          message =
              "User registered successfully! Check your email to activate your account.";
        });

        // Show an AlertDialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Success"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {
        // Handle errors
        var responseBody = jsonDecode(response.body);
        setState(() {
          message = responseBody['email']?.join(', ') ??
              responseBody['name']?.join(', ') ??
              responseBody['password']?.join(', ') ??
              "Registration failed!";
        });
        print("Response Body: ${response.body}"); // Debug response
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        message = "Error occurred: $e";
      });
      print("Error: $e"); // Debug error
    }
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Background and ClipPaths
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: screenHeight * 0.30, // 40% of the screen height
                  width: double.infinity,
                  color: MyColors().maincolor.withOpacity(0.7),
                ),
              ),
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: screenHeight * 0.25, // 30% of the screen height
                  width: double.infinity,
                  color: MyColors().maincolor,
                ),
              ),
              SizedBox(
                height: screenHeight,
                width: screenWidth,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 100, // 7% from the top
                    left: screenWidth * 0.07, // 7% from the left
                  ),
                  child: Text(
                    'Welcome to \n ZadqaZakat',
                    style: TextStyle(
                      fontSize: screenHeight * 0.04, // 4% of the screen height
                      color: const Color.fromARGB(255, 4, 4, 4),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // Signup Form positioned on top of the stack
              Positioned(
                top: 50,
                right: 0,
                child: _buildSignupForm(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignupForm(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Form(
        key: signup,
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.20), // 25% from the top
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white,
            ),
            height: 900, // Full screen height
            // height: double.infinity,
            width: screenWidth, // Full screen width
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.07, // 7% horizontal padding
              ),
              child: SingleChildScrollView(
                child: Container(
                  // color: Colors.red,
                  height: 1100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02), // 5% vertical space
                      Text(
                        "Create new account now",
                        style: TextStyle(
                          fontSize: screenHeight * 0.02, // 2% of screen height
                          color: MyColors().maincolor,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      // SizedBox(height: screenHeight * 0.01), // 2% vertical space
                      _buildTextField("Full Name", name),
                      _buildTextField("Email", email),
                       buildPhone("Contact Number",phoneNumberController),
                      _buildTextField("WhatsApp Number", whatsapp),
                      _buildTextField("Nationality", nationality),
                      _buildTextField("City Of Residense", residense),
                      _buildTextField("Password", password, isPassword: true),
                      _buildTextField("Confirm Password", conpassword,
                          isPassword: true),
                      // SizedBox(height: screenHeight * 0.04), // 4% vertical space
                  
                      // Signup Button
                      InkWell(
                        onTap: () {
                          if (signup.currentState!.validate()) {
                            if (password.text == conpassword.text) {
                              // Register user
                              _registerUser(
                                name.text,
                                email.text,
                                password.text,
                                nationality.text,
                                // phoneNumberController.value.toString(),
                                whatsapp.text,
                                residense.text,
                                phoneNumberController.value.toString()
                              );
                            } else {
                              setState(() {
                                message = "Passwords do not match!";
                              });
                            }
                          }
                        },
                        child: Container(
                          height: screenHeight * 0.07, // 7% of the screen height
                          width: screenWidth * 0.8, // 80% of the screen width
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: MyColors().maincolor,
                          ),
                          child: isLoading
                              ? const Center(
                                  child:
                                      CircularProgressIndicator(color: Colors.white))
                              : const Center(
                                  child: Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01), // 3% vertical space
                  
                      // Error or Success Message
                      message.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                message,
                                style: TextStyle(
                                  color: message == "User registered successfully!"
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : const SizedBox(),
                  
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontSize: screenHeight * 0.02, // 2% of screen height
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            SizedBox(
                                height: screenHeight * 0.01), // 2% vertical space
                            InkWell(
                              onTap: () {
                                // Navigate to login
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: Text(
                                "Click here",
                                style: TextStyle(
                                  fontSize:
                                      screenHeight * 0.02, // 2% of screen height
                                  color: MyColors().maincolor,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ).animate().fade().slideY(
              begin: 1,
              duration: const Duration(milliseconds: 600),
            ),
      ),
    );
  }

  Widget buildPhone(String hint, PhoneNumberEditingController controller) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(16),
        // child: Column(
          // children: <Widget>[
           child: PhoneNumberField(
              controller: controller,
              decoration: InputDecoration(
            hintText: hint,
            border: const UnderlineInputBorder(),
          ),
            ),
          // ],
        // ),
      ),
    );
  }
  //             print("button is press ${controller.nationalNumber}");
  //             print("button is press ${controller.value}");
  // // Custom TextField Widget
  Widget _buildTextField(String hint, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16), // 16 pixels of vertical space
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? secure : false,
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(secure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      secure = !secure;
                    });
                  },
                )
              : null,
          border: const UnderlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$hint cannot be empty';
          }
          return null;
        },
      ),
    );
  }
}
