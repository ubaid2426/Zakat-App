import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // For token storage

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Controller for the input field
  final TextEditingController _currentPasswordController = TextEditingController();
  
  bool _isLoading = false;
  String _errorMessage = '';

  // Method to handle account deletion
  Future<void> _deleteAccount() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      // Get token from secure storage
      String? token = await storage.read(key: 'access_token');
      
      // Prepare request
      var url = Uri.parse('https://sadqahzakaat.com/api/auth/users/me/');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'JWT $token', // Attach the access token
      };
      var body = jsonEncode({
        'current_password': _currentPasswordController.text,
      });

      // Send HTTP DELETE request
      try {
        var response = await http.delete(url, headers: headers, body: body);
        if (response.statusCode == 204) {
          // Account deleted successfully
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Account deleted successfully!')),
          );
          // ignore: use_build_context_synchronously
          Navigator.pop(context); // Optionally pop back to previous screen
        } else {
          setState(() {
            _errorMessage = 'Failed to delete account: ${response.body}';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Error occurred: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account'),
           flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF33A248), Color(0xFFB2EA50)],
              begin: Alignment.topRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
  key: _formKey,
  child: Padding(
    padding: const EdgeInsets.all(16.0), // Adds padding around the form
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // Ensures children take full width
      children: [
        // Current Password Field
        TextFormField(
          controller: _currentPasswordController,
          decoration: InputDecoration(
            labelText: 'Current Password',
            labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.green, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
          ),
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your current password';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),

        // Delete Account Button
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: _deleteAccount,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
        const SizedBox(height: 20),

        // Error Message Display
        if (_errorMessage.isNotEmpty)
          Text(
            _errorMessage,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center, // Centers the error message
          ),
      ],
    ),
  ),
)

      ),
    );
  }
}
