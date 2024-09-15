import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
// import 'package:get/get.dart';
import 'package:zakat_app/Screens/Login/Screen/login_page.dart';
// import 'package:zakat_app/Screens/Login/auth/screens/login.dart';
import 'package:zakat_app/Screens/Login/components/colors.dart';
import 'package:zakat_app/Screens/Login/components/clipper.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool secure = true;
  GlobalKey<FormState> signup = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get screen height and width for responsive design
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return
        // Scaffold(
        SingleChildScrollView(
      child: Stack(
        children: [
          // Background and ClipPaths
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: screenHeight * 0.4, // 40% of the screen height
              width: double.infinity,
              color: MyColors().maincolor.withOpacity(0.7),
            ),
          ),
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: screenHeight * 0.3, // 30% of the screen height
              width: double.infinity,
              color: MyColors().maincolor,
            ),
          ),
          Container(
            height: screenHeight,
            width: screenWidth,
            child: Padding(
              padding: EdgeInsets.only(
                top: 200, // 7% from the top
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
            top: 100,
            right: 0,
            child: _buildSignupForm(context),
          ),
        ],
      ),
      // ),
    );
  }

  Widget _buildSignupForm(BuildContext context) {
    // Get screen height and width for responsive design
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Form(
      key: signup,
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.25), // 25% from the top
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Colors.white,
          ),
          height: screenHeight, // Full screen height
          width: screenWidth, // Full screen width
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.07, // 7% horizontal padding
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.05), // 5% vertical space
                Text(
                  "Create new account now",
                  style: TextStyle(
                    fontSize: screenHeight * 0.02, // 2% of screen height
                    color: MyColors().maincolor,
                    decoration: TextDecoration.none,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02), // 2% vertical space
                _buildTextField("Full Name", name),
                _buildTextField("Email", email),
                _buildTextField("Password", password, isPassword: true),
                // _buildTextField("Address", address),
                SizedBox(height: screenHeight * 0.04), // 4% vertical space
                InkWell(
                  onTap: () {
                    // Handle signup logic here
                  },
                  child: Container(
                    height: screenHeight * 0.07, // 7% of the screen height
                    width: screenWidth * 0.8, // 80% of the screen width
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: MyColors().maincolor,
                    ),
                    child: const Center(
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
                SizedBox(height: screenHeight * 0.03), // 3% vertical space
                Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize:
                              screenHeight * 0.02, // 2% of the screen height
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                          height: screenHeight * 0.02), // 2% vertical space
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage()), // Navigate to the screen
                          );
                        },
                        child: Text(
                          "Click here",
                          style: TextStyle(
                            fontSize:
                                screenHeight * 0.02, // 2% of screen height
                            color: MyColors().maincolor,
                            decoration: TextDecoration.none,
                            // decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
          .animate()
          .fade()
          .slideY(begin: 1, duration: const Duration(milliseconds: 600)),
    );
  }

  // Custom TextField Widget
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
