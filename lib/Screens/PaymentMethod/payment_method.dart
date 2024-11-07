import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:zakat_app/Screens/Profile/Screens/my_detail.dart';
import 'package:zakat_app/components/custom_button.dart';
import 'package:http/http.dart' as http;

class PaymentMethod extends StatefulWidget {
  final double? placeholderText;
  const PaymentMethod({super.key, required this.placeholderText});

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  File? _image; // To store the selected image
  String paymentStatus = 'Pending'; // Initial payment status
  final storage = FlutterSecureStorage();

  Future<void> recordDonation(
      String donationId, String donorName, double amount, File? image) async {
    final uri = Uri.parse('http://127.0.0.1:8000/data/donor-history/');

    // Retrieve donor details from secure storage
    String? donationId = await storage.read(key: 'donationId');
    String? donorName = await storage.read(key: 'donorName');

    // Ensure both donorName and donationId are not null
    if (donationId == null || donorName == null) {
      print('Error: Donor name or donation ID is missing.');
      return;
    }

    // Set up multipart request
    var request = http.MultipartRequest('POST', uri);
    request.fields['donation_id'] = donationId;
    request.fields['donor_name'] = donorName;
    request.fields['amount'] = amount.toString();

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Donation recorded successfully.');
      } else {
        print('Failed to record donation.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Function to pick an image
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to verify payment (simulating admin verification)
  void _verifyPayment() {
    setState(() {
      paymentStatus = 'Completed'; // Simulate verification
    });
    // Here, in a real app, you would notify the admin to verify the payment
    // Once verified by the admin, the status would change
  }

  // Build Payment Method Screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7fc23a),
        title: const Text('Payment Methods'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildPaymentMethodCard(
                title: 'Local Bank Transfer',
                accountNumber: '3088383000001023',
                bankName: 'Faysal Bank',
                accountHolder: 'Zuha Rashid',
                icon: FontAwesomeIcons.buildingColumns,
              ),
              const SizedBox(height: 20),
              buildPaymentMethodCard(
                title: 'International Donors',
                accountNumber: 'PK23FAYS3088383000001023',
                bankName: 'Faysal Bank',
                accountHolder: 'Zuha Rashid',
                icon: FontAwesomeIcons.globe,
              ),
              const SizedBox(height: 20),
              buildPaymentMethodCard(
                title: 'Jazzcash',
                accountNumber: '03363582087',
                bankName: 'Jazzcash',
                accountHolder: 'Zuha Rashid',
                icon: FontAwesomeIcons.mobileAlt,
              ),
              const SizedBox(height: 20),
              buildPaymentMethodCard(
                title: 'PayPal (For International Donors)',
                accountNumber: 'paypal@donationexample.com',
                bankName: 'PayPal',
                accountHolder: 'Zuha Rashid',
                icon: FontAwesomeIcons.paypal,
              ),
              ValueReader(widget.placeholderText.toString()),
              const SizedBox(height: 30),
              buildImagePickerSection(),
              const SizedBox(height: 20),
              buildPaymentStatus(),
              const SizedBox(height: 20),
              Center(
                child: CustomButton(
                  title: "Verify Payment",
                  icon: FontAwesomeIcons.moneyCheck,
                  onNavigate:  recordDonation(
        'donationId',       // Replace with actual donationId or retrieve it from storage
        'donorName',         // Replace with actual donorName or retrieve it from storage
        widget.placeholderText ?? 0.0,
        _image,
      );
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display each payment method
  Widget buildPaymentMethodCard({
    required String title,
    required String accountNumber,
    required String bankName,
    required String accountHolder,
    required IconData icon,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: const Color(0xFF7fc23a)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Account Number: $accountNumber',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Bank Name: $bankName',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Account Holder: $accountHolder',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Image picker section
  Widget buildImagePickerSection() {
    return Column(
      children: [
        const Text(
          'Upload Payment Screenshot:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _image == null
            ? const Text('No image selected.')
            : Image.file(_image!, height: 150, width: 150, fit: BoxFit.cover),
        const SizedBox(height: 10),
        Center(
          child: CustomButton(
              title: "Choose Image",
              icon: Icons.camera_alt,
              onNavigate: _pickImage),
        ),
      ],
    );
  }

//  @override
  // ignore: non_constant_identifier_names
  Widget ValueReader(String placeholderText) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Text(
        placeholderText,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 16.0,
        ),
      ),
    );
  }

  // Payment status section
  Widget buildPaymentStatus() {
    return Column(
      children: [
        const Text(
          'Payment Status:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          paymentStatus,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: paymentStatus == 'Completed'
                ? Colors.green
                : Colors.orangeAccent,
          ),
        ),
        const SizedBox(height: 10),
        if (paymentStatus == 'Pending')
          const Text(
            'Your payment is pending verification. Please wait for the admin to verify.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          )
        else if (paymentStatus == 'Completed')
          const Text(
            'Your payment has been verified! Thank you for your contribution.',
            style: TextStyle(fontSize: 14, color: Colors.green),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
