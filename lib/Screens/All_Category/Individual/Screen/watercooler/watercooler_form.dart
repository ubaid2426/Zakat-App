import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:http/http.dart' as http;

class WaterCoolerForm extends StatefulWidget {
  // final String selectedCategory;

  const WaterCoolerForm({
    super.key,
    // required this.selectedCategory,
  });

  @override
  // ignore: library_private_types_in_public_api
  _WaterCoolerFormState createState() => _WaterCoolerFormState();
}

class _WaterCoolerFormState extends State<WaterCoolerForm> {
    final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bloodtypeController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _timerequiredController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
// import 'package:http/http.dart' as http;
// import 'dart:convert';

  Future<void> _submitForm() async {
double? distance = double.tryParse(_distanceController.text);
// double? quantity = double.tryParse(widget.selectedCategory);
    if (_formKey.currentState!.validate()) {
      // Gather data from form fields
      final data = {
        "name": _nameController.text,
        "contact_number": _phoneController.text,
        "blood_type": _bloodtypeController.text,
        "distance_km": distance,
        "time_required": _timerequiredController.text,
        // "quantity": quantity,
      };

      try {
        print(data);
        // Send the POST request
        final response = await http.post(
          Uri.parse('https://sadqahzakaat.com/data/blood-requests/'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data),
        );

        // Check the response status
        if (response.statusCode == 201) {
          // Successfully created
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Donation request submitted successfully')),
          );
        } else {
          // Handle server error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit: ${response.body}')),
          );
        }
      } catch (e) {
        // Handle network or other errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Donations Form'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF33A248), Color(0xFFB2EA50)],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ExpandableText(
                  "Save a life today – your blood can be someone's second chance at life!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _nameController,
                  label: 'Name',
                  hint: 'E.g. Ali',
                  icon: Icons.person,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _phoneController,
                  label: 'Contact Number',
                  hint: 'E.g. +92 3000000000',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _bloodtypeController,
                  label: 'Blood Type',
                  hint: 'E.g. AB-',
                  icon: Icons.bloodtype,
                  // keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _distanceController,
                  label: 'Distance',
                  hint: '5.5km',
                  icon: Icons.description,
                  // maxLines: 4,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _timerequiredController,
                  label: 'Time Required',
                  hint: '00:15:00',
                  icon: Icons.location_on,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Submitting form')),
                          );
                        }
                        _submitForm();
                      },
                      icon: const Icon(Icons.send),
                      label: const Text('SUBMIT'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xFF7fc23a),
                        textStyle: const TextStyle(
                          fontSize: 18,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF7fc23a)),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF7fc23a), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        if (label == 'Amount Required' && double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        return null;
      },
    );
  }
}
