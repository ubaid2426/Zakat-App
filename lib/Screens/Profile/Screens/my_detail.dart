import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sadqahzakat/Screens/Login/Screen/login_page.dart';
import 'package:sadqahzakat/Screens/Profile/Screens/Settings/MyDetailScreens/change_pass.dart';
import 'package:sadqahzakat/Screens/Profile/Screens/Settings/MyDetailScreens/delete_acc.dart';
import 'package:sadqahzakat/components/custom_button.dart';
// FlutterSecureStorage instance for token management
const storage = FlutterSecureStorage();

class MyDetail extends StatefulWidget {
  const MyDetail({super.key});

  @override
  _MyDetailState createState() => _MyDetailState();
}

class _MyDetailState extends State<MyDetail> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userIdController = TextEditingController(); // User ID field
  bool isLoading = true;
  bool isUpdating = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _checkAccessToken();
  }

  // Check for access token, if not available, redirect to login
  Future<void> _checkAccessToken() async {
    setState(() {
      isLoading = true;
    });

    String? token = await storage.read(key: 'access_token');
    print("Retrieved token: $token");

    if (token == null) {
      setState(() {
        errorMessage = 'Please log in to access your details.';
        isLoading = false;
      });
      _redirectToLogin();
    } else {
      _fetchUserDetails(token);
    }
  }

  // Navigate to Login Page if user is not authenticated
  void _redirectToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  // Refresh Token Method
  Future<void> _refreshToken() async {
    setState(() {
      isLoading = true;
    });

    String? refreshToken = await storage.read(key: 'refresh_token');
    print("Refreshing with token: $refreshToken");

    if (refreshToken == null) {
      print("No refresh token found, redirecting to login");
      _redirectToLogin(); // No refresh token found, force re-login
    } else {
      var url = Uri.parse('http://127.0.0.1:8000/api/auth/jwt/refresh/');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'refresh': refreshToken}),
      );

      print("Token refresh response code: ${response.statusCode}");
      print("Token refresh response body: ${response.body}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        String newAccessToken = data['access'];
        print("New access token: $newAccessToken");

        await storage.write(key: 'access_token', value: newAccessToken);
        _fetchUserDetails(newAccessToken); // Retry fetching user details
      } else {
        print("Refresh token invalid, redirecting to login");
        _redirectToLogin(); // If token refresh fails, redirect to login
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  // Fetch User Details from API
  Future<void> _fetchUserDetails(String token) async {
    setState(() {
      isLoading = true;
    });

    try {
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
          userIdController.text = data['id'].toString(); // Fetch and display user ID
          isLoading = false;
        });
  

        // Save name and id in FlutterSecureStorage
      await storage.write(key: 'user_name', value: data['name']);
      await storage.write(key: 'user_id', value: data['id'].toString());

      } else if (response.statusCode == 401) {
        print("Access token is invalid or expired, refreshing token...");
        await _refreshToken(); // Attempt to refresh token
      } else {
        setState(() {
          errorMessage = 'Failed to load details: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching user details: $e");
      setState(() {
        errorMessage = 'Error occurred: $e';
        isLoading = false;
      });
    }
  }

  // Update User Details
  Future<void> _updateUserDetails(String token) async {
    setState(() {
      isUpdating = true;
    });

    try {
      var url = Uri.parse('http://127.0.0.1:8000/api/auth/users/me/');
      Map<String, String> body = {'name': nameController.text};

      var response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'JWT $token',
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

  // Show Error Message in Alert Dialog
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
                Navigator.of(context).pop();
                setState(() {
                  errorMessage = ''; // Clear the error message after showing
                });
              },
            ),
          ],
        );
      },
    );
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
                    'User ID:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: userIdController,
                    readOnly: true, // User ID is non-editable
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User ID',
                    ),
                  ),
                  const SizedBox(height: 24),
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
                    readOnly: true, // Email is non-editable
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
                  ),
                ],
              ),
            ),
    );
  }
}
