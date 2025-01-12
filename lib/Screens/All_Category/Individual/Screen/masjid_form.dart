import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
// import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sadqahzakat/Screens/Login/Screen/login_page.dart';

class MasjidConstForm extends StatefulWidget {
  const MasjidConstForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MasjidConstFormState createState() => _MasjidConstFormState();
}

class _MasjidConstFormState extends State<MasjidConstForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _optionalController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
   TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  bool isLoading = true;
  bool isUpdating = false;
  String errorMessage = '';
    void initState() {
    super.initState();
    _checkAccessToken();
  }
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> donationOptionsmeal = [
    {'title': 'You will give land', 'price': 0},
    {
      'title':
          'You contribute in Constuction \n like (Bricks, Marble, cement, Electric Equipment etc)',
      'price': 0
    },
    // {'title': 'Electric WheelChair', 'price': 10000},
  ];
  Map<String, dynamic>? selectedDonation;
  // String? _selectedDonationOption;
  String? donationtitle;
  double? amount;
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Gather data from form fields
      final data = {
        "name": _nameController.text,
        "contact_number": _phoneController.text,
        "current_location": _addressController.text,
        "optional": _optionalController.text,
        "donation_type": donationtitle,
        'amount': amount,
      };

      try {
        print(data); // For debugging
        // Send the POST request
        final response = await http.post(
          Uri.parse(
              'https://sadqahzakaat.com/data/donationsindividual/'), // Replace with your API endpoint
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data),
        );

        // Check the response status
        if (response.statusCode == 201) {
          _showSuccessDialog();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Donation request submitted successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
void _showloginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text(
            'Please log in to access the form and help those in need.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchUserDetails(String token) async {
    setState(() {
      isLoading = true;
    });

    try {
      var url = Uri.parse('https://sadqahzakaat.com/api/auth/users/me/');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'JWT $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          nameController.text = data['name'] ?? 'N/A';
          emailController.text = data['email'] ?? 'N/A';
          userIdController.text = data['id'].toString();
          isLoading = false;
        });
      } else {
        _showloginDialog();
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error occurred: $e';
        isLoading = false;
      });
    }
  }


  Future<void> _checkAccessToken() async {
    setState(() {
      isLoading = true;
    });

    String? token = await storage.read(key: 'access_token');
    if (token == null) {
      _showloginDialog();
    } else {
      _fetchUserDetails(token);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text(
            'Your donation request has been successfully uploaded. The admin will contact you as soon as possible.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masjid Construction Form'),
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
                // _buildDropdown(),
                _buildDonationDropdown(),

                const SizedBox(height: 20),
                _buildTextField(
                  controller: _addressController,
                  label: 'Current Address',
                  hint: 'E.g House no, Society and City',
                  icon: Icons.home_filled,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _optionalController,
                  label: 'For whose sake are you giving charity?',
                  hint: 'E.g. Shahid',
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ElevatedButton.icon(
                      onPressed: _submitForm,
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
        return null;
      },
    );
  }

  Widget _buildDonationDropdown() {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Text(
              'Select a donation option:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF7fc23a),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<Map<String, dynamic>>(
                isExpanded: true,
                hint: const Text(
                  'Choose a donation option',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                value: selectedDonation,
                items: donationOptionsmeal
                    .map((option) => DropdownMenuItem<Map<String, dynamic>>(
                          value: option,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                option['title'],
                                style: TextStyle(fontSize: 13),
                              ),
                              Text('Rs ~ ${option['price']}'),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedDonation = newValue;
                    donationtitle = selectedDonation?['title'];
                    amount = selectedDonation?['price']?.toDouble();
                    // updateTotalAmount();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
