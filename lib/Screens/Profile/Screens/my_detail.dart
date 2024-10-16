import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zakat_app/Screens/Login/Screen/login_page.dart';
import 'package:zakat_app/Screens/Profile/Screens/Settings/MyDetailScreens/change_pass.dart';
import 'package:zakat_app/Screens/Profile/Screens/Settings/MyDetailScreens/delete_acc.dart';
import 'package:zakat_app/components/custom_button.dart'; // For token storage

class MyDetail extends StatefulWidget {
  const MyDetail({super.key});

  @override
  _MyDetailState createState() => _MyDetailState();
}

class _MyDetailState extends State<MyDetail> {
  final FlutterSecureStorage storage =
      const FlutterSecureStorage(); // For securely storing the access token
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isLoading = true;
  bool isUpdating = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _checkAccessToken();
  }

  Future<void> _checkAccessToken() async {
    setState(() {
      isLoading = true;
    });

    String? token = await storage.read(key: 'access_token');
    print("Retrieved token: $token"); // Add this for debugging

    if (token == null) {
      // No access token found, redirect to login page
      setState(() {
        errorMessage = 'Please log in to access your details.';
        isLoading = false;
      });
      _redirectToLogin(); // Navigate to login
    } else {
      // Proceed to fetch user details
      _fetchUserDetails(token);
    }
  }

// Method to navigate to Login Page
  void _redirectToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

// Refresh token method
// Future<void> _refreshToken() async {
//   setState(() {
//     isLoading = true;
//   });

//   String? refreshToken = await storage.read(key: 'refresh_token');
//   print("Refreshing with token: $refreshToken");

//   if (refreshToken == null) {
//     print("No refresh token found, redirecting to login");
//     _redirectToLogin(); // Navigate to login if no refresh token
//   } else {
//     var url = Uri.parse('http://127.0.0.1:8000/api/auth/jwt/refresh/');
//     var response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'refresh': refreshToken}),
//     );

//     print("Token refresh response code: ${response.statusCode}");
//     print("Token refresh response body: ${response.body}");

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       String newAccessToken = data['access'];
//       print("New access token: $newAccessToken");

//       // Save the new access token
//       await storage.write(key: 'access_token', value: newAccessToken);

//       // Fetch user details with the new access token
//       _fetchUserDetails(newAccessToken);
//     } else {
//       print("Refresh token invalid, redirecting to login");
//       _redirectToLogin(); // Refresh token is invalid, force re-login
//     }
//   }

//   setState(() {
//     isLoading = false;
//   });
// }

  Future<void> _fetchUserDetails(String token) async {
    setState(() {
      isLoading = true; // Show loader while fetching details
    });

    try {
      // http.Response response;
      // response =
      // await http.get(Uri.parse('http://127.0.0.1:8000/api/auth/users/me/'));

      var url = Uri.parse('http://127.0.0.1:8000/api/auth/users/me/');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'JWT $token',
        },
      );

      print("Fetch user details response code: ${response.statusCode}");
      print("Fetch user details response body: ${response.body}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          nameController.text = data['name'] ?? 'N/A';
          emailController.text = data['email'] ?? 'N/A';
          isLoading = false; // Hide loader once data is fetched
        });
      }
      // else if (response.statusCode == 401) {
      //   print("Access token is invalid or expired, trying to refresh token...");
      //   // await _refreshToken();
      // } else {
      //   setState(() {
      //     errorMessage = 'Failed to load details: ${response.statusCode}';
      //     isLoading = false;
      //   });
      // }
    } catch (e) {
      print("Error occurred while fetching user details: $e");
      setState(() {
        errorMessage = 'Error occurred: $e';
        isLoading = false; // Hide loader on error
      });
    }
  }

  Future<void> _updateUserDetails(String token) async {
    setState(() {
      isUpdating = true;
    });

    try {
      // API URL for updating user details
      var url = Uri.parse('http://127.0.0.1:8000/api/auth/users/me/');

      // Data to be updated
      Map<String, String> body = {
        'name': nameController.text,
        // Add any other fields if required
      };

      // HTTP PATCH request to update user details
      var response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'JWT $token', // Attach the access token
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        setState(() {
          errorMessage = 'Details updated successfully!';
          isUpdating = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to update details: ${response.statusCode}';
          isUpdating = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error occurred: $e';
        isUpdating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show error message in an alert dialog
    if (errorMessage.isNotEmpty) {
      Future.delayed(
          Duration.zero, () => _showErrorDialog(context, errorMessage));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Details'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Email:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: emailController,
                    readOnly: true, // Email is not editable
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 24),
                  isUpdating
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            String? token =
                                await storage.read(key: 'access_token');
                            if (token != null) {
                              _updateUserDetails(token);
                            }
                          },
                          child: const Text('Update Details'),
                        ),
                  const SizedBox(height: 16),
                  const CustomButton(
                    title: "Change Password",
                    icon: FontAwesomeIcons.lock,
                    navigateTo: ChangePasswordScreen(),
                  ),
                  const CustomButton(
                    title: "Delete Account",
                    icon: FontAwesomeIcons.trash,
                    navigateTo: DeleteAccountScreen(),
                  )
                ],
              ),
            ),
    );
  }

// Function to display the error message in an alert dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                setState(() {
                  errorMessage = ''; // Clear the error message after showing it
                });
              },
            ),
          ],
        );
      },
    );
  }
}
