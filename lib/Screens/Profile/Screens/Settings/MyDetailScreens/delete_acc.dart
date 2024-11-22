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
      var url = Uri.parse('http://127.0.0.1:8000/api/auth/users/me/');
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _currentPasswordController,
                decoration: const InputDecoration(labelText: 'Current Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _deleteAccount,
                      child: const Text('Delete Account'),
                    ),
              const SizedBox(height: 20),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
