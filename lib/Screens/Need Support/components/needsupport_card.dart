import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:http/http.dart' as http;

class NeedSupport extends StatefulWidget {
  final String selectedCategory;

  const NeedSupport({
    super.key,
    required this.selectedCategory,
  });

  @override
  _NeedSupportState createState() => _NeedSupportState();
}

class _NeedSupportState extends State<NeedSupport> {
  final _formKey = GlobalKey<FormState>();
// import 'package:http/http.dart' as http;
// import 'dart:convert';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Gather data from form fields
      final data = {
        "name": _nameController.text,
        "phone": _phoneController.text,
        "amount_required": _amountController.text,
        "description": _descriptionController.text,
        "street_address": _streetAddressController.text,
        "apartment": _apartmentController.text,
        "city": _cityController.text,
        "state": _stateController.text,
        "country": _selectedCountry,
        "is_zakat": _isZakat,
        "is_sadqah": _isSadqah,
      };

      try {
        // Send the POST request
        final response = await http.post(
          Uri.parse('https://sadqahzakaat.com/data/donation-request/'),
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  String? _selectedCountry;
  bool _isZakat = false;
  bool _isSadqah = false;

  final List<String> _countries = [
    'Australia',
    'United States',
    'United Kingdom',
    'India',
    'Pakistan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request For Donations'),
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
                  'If you need assistance from any of the categories below, please fill out the form...',
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
                  label: 'Phone',
                  hint: 'E.g. +1 300 400 5000',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                Text(
                  'Category: ${widget.selectedCategory}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7fc23a),
                  ),
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _amountController,
                  label: 'Amount Required',
                  hint: 'E.g. 1000',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _descriptionController,
                  label: 'Description',
                  hint: 'E.g. You can add a new line',
                  icon: Icons.description,
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _streetAddressController,
                  label: 'Street Address',
                  hint: 'E.g. 42 Wallaby Way',
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _apartmentController,
                  label: 'Apartment, suite, etc.',
                  hint: 'Optional',
                  icon: Icons.home,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _cityController,
                        label: 'City',
                        hint: 'E.g. Sydney',
                        icon: Icons.location_city,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _stateController,
                        label: 'State/Province',
                        hint: 'E.g. New South Wales',
                        icon: Icons.map,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildDropdown(),
                const SizedBox(height: 16),

                // Add Checkboxes for Zakat and Sadqah
                CheckboxListTile(
                  title: const Text('Zakat'),
                  value: _isZakat,
                  onChanged: (bool? value) {
                    setState(() {
                      _isZakat = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: const Color(0xFF7fc23a),
                ),
                CheckboxListTile(
                  title: const Text('Sadqah'),
                  value: _isSadqah,
                  onChanged: (bool? value) {
                    setState(() {
                      _isSadqah = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: const Color(0xFF7fc23a),
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

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Country *',
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
      value: _selectedCountry,
      onChanged: (String? newValue) {
        setState(() {
          _selectedCountry = newValue;
        });
      },
      items: _countries.map<DropdownMenuItem<String>>((String country) {
        return DropdownMenuItem<String>(
          value: country,
          child: Text(country),
        );
      }).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select a country';
        }
        return null;
      },
    );
  }
}
