import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sadqahzakat/Screens/Home/home_main.dart';
import 'package:sadqahzakat/Screens/Login/Screen/sing_up.dart';
import 'package:sadqahzakat/Screens/Login/auth/widgets/email_field.dart';
import 'package:sadqahzakat/Screens/Login/auth/widgets/password_field.dart';
import 'package:sadqahzakat/Screens/Login/components/clipper.dart';
import 'package:sadqahzakat/Screens/Login/components/colors.dart';
import 'package:sadqahzakat/Screens/Login/components/const.dart';
import 'package:sadqahzakat/components/navigation.dart';
import 'package:sadqahzakat/main.dart';
// Secure storage for token
const storage = FlutterSecureStorage();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool secure = true;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login(String email, String password) async {
    // Ensure widget is still mounted before calling setState
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    var url = Uri.parse('http://127.0.0.1:8000/api/auth/jwt/create/');
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Ensure widget is still mounted before calling setState
      if (!mounted) return;

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String accessToken = data['access'];

        // Save token securely
        await storage.write(key: 'access_token', value: accessToken);

        // Show success message using ScaffoldMessenger
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You are successfully logged in!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to home page on success
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Navigation()),
          );
        }
      } else {
        // Show error message using ScaffoldMessenger
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed. Please check your credentials.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                width: width,
                height: height,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        height: 300,
                        width: width,
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
                                "Enter your email to continue",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black26,
                                ),
                              ),
                              const SizedBox(height: 50),
                              Form(
                                key: loginKey,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.05),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      EmailField(email: emailController),
                                      PasswordField(
                                          password: passwordController),
                                      const SizedBox(height: 20),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ForgotPasswordPage()),
                                            );
                                          },
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                              color: MyColors().maincolor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      InkWell(
                                        onTap: () {
                                          if (loginKey.currentState!
                                              .validate()) {
                                            login(emailController.text,
                                                passwordController.text);
                                          }
                                        },
                                        child: Container(
                                          height: 55,
                                          width: 300,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
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
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Signup()),
                                          );
                                        },
                                        child: Text(
                                          "Don't have an account? Click here",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: MyColors().maincolor,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Navigation()), // Navigate to the screen
                                            // const Home()), // Navigate to the screen
                                  );
                                },
                                child: Container(
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors().maincolor,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Go TO Home Page',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  String message = '';

  Future<void> sendResetPasswordEmail(
      String email, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        message = 'Password reset email has been sent.';
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Email Sent'),
            content: const Text(
                'A password reset link has been sent to your email. Please check your inbox.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop(); // Go back to login screen
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
    // }

    var url = Uri.parse('http://127.0.0.1:8000/api/auth/users/reset_password/');
    Map<String, String> body = {
      'email': email,
    };

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 204) {
        // Here you would typically receive the token and UUID in the response
        // For example: {"uid": "some-uuid", "token": "some-token"}

        var responseBody = json.decode(response.body);

        String uid =
            responseBody['uid']; // Replace with actual field if different
        // print(uid);
        String token =
            responseBody['token']; // Replace with actual field if different
        // print(token);
        // Save token and UUID in Flutter Secure Storage
        await storage.write(key: 'reset_uid', value: uid);
        await storage.write(key: 'reset_token', value: token);

        setState(() {
          message = 'Password reset email sent!';
        });
      } else {
        setState(() {
          message = 'Failed to send email. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Enter your email to reset password',
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      sendResetPasswordEmail(emailController.text, context);
                    },
                    child: const Text('Send Reset Email'),
                  ),
            const SizedBox(height: 20),
            if (message.isNotEmpty)
              Text(
                message,
                style: const TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}
