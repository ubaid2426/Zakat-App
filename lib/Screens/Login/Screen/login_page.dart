import 'package:flutter/material.dart';
// import 'package:zakat_app/Screens/Home/home_main.dart';
// import 'package:get/get.dart';
import 'package:zakat_app/Screens/Login/Screen/sing_up.dart';
// import 'package:zakat_app/Screens/Login/Screen/sing_up.dart';
// import 'package:zakat_app/Screens/Login/auth/screens/signup.dart';
import 'package:zakat_app/Screens/Login/auth/widgets/email_field.dart';
import 'package:zakat_app/Screens/Login/auth/widgets/password_field.dart';
import 'package:zakat_app/Screens/Login/components/clipper.dart';
import 'package:zakat_app/Screens/Login/components/colors.dart';
import 'package:zakat_app/Screens/Login/components/const.dart';
// import 'package:zakat_app/components/homeScreen_carousel.dart';
import 'package:zakat_app/components/navigation.dart';
// import 'package:zakat_app/Screens/Login/components/const.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool secure = true;
  GlobalKey<FormState> login = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "Login",
      //     style: TextStyle(fontSize: 25),
      //   ),
      // ),
      body: SizedBox(
        width: _width,
        height: _height,
        child: Stack(
          children: [
            SizedBox(height: 400, width: 200,),

            // AppBar(
            //  IconButton(
            //     onPressed: () => Navigator.pop(context),
            //     icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 7, 7),),
            //   ),
            // ),
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 300,
                width: _width,
                color: primaryColor.withOpacity(0.3),
              ),
            ),
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width - 50,
                color: primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
                left: 20,
                top: 200,
                bottom: 50,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Enter your Gmail to continue",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black26,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Form(
                        key: login,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: _width * 0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              EmailField(email: email),
                              PasswordField(password: password),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: MyColors().maincolor,
                                  ),
                                ),
                              ),
                              SizedBox(height: _height * 0.05),
                              InkWell(
                                onTap: () {
                                  // if (login.currentState!.validate()) {
                                  //   login_fun(email.text, password.text);
                                  // }
                                },
                                child: Container(
                                  height: 55,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: MyColors().maincolor,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'SIGN IN',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: _height * 0.05),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Don't have an account?",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: _height * 0.02),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Signup()), // Navigate to the screen
                                        );
                                      },
                                      child: Text(
                                        "click here",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: MyColors().maincolor,
                                          decoration: TextDecoration.underline,
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
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Navigation(),
                    ),
                  );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: primaryColor),
                      ),
                      child: const Center(
                        child: Text(
                          "Home Page",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
