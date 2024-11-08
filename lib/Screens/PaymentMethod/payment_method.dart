import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zakat_app/Screens/PaymentMethod/check_image.dart';
import 'package:zakat_app/components/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:zakat_app/model/payment_detail.dart';
import 'package:image/image.dart' as img;
// FlutterSecureStorage instance for token management
const storage = FlutterSecureStorage();

class PaymentMethod extends StatefulWidget {
  final double? placeholderText;
  final String? donationtitle;
  const PaymentMethod(
      {super.key, required this.placeholderText, required this.donationtitle});

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  File? imageFile;
  String paymentStatus = 'Pending';

  Future<PaymentDetail?> recordDonation() async {
    PaymentDetail? paymentDetail;
    String? token = await storage.read(key: 'access_token');
    String? donorName = await storage.read(key: 'user_name');
    String? donorId = await storage.read(key: 'user_id');

    if (token == null || donorName == null || donorId == null) {
      print('Error: Missing token or user details.');
      return null;
    }

    final url = Uri.parse('http://127.0.0.1:8000/data/donor-history/');
    final headers = {
      'Authorization': 'JWT $token',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'donor_name': donorName,
      'donor_id': donorId,
      'amount': widget.placeholderText ?? 0.0,
      'donation_title': widget.donationtitle,
    };

    if (imageFile != null) {
      // Convert image to base64 to send it as a string
      body['payment_image'] = base64Encode(await imageFile!.readAsBytes());
    }

    // Debugging output to verify the body and headers
    print("Headers: $headers");
    print("Body: ${json.encode(body)}");

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        print('Donation recorded successfully.');
        paymentDetail = PaymentDetail.fromJson(json.decode(response.body));
      } else {
        print('Failed to record donation. Status code: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('Error: $e');
    }

    return paymentDetail;
  }

Future<void> _pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
   imageFile = File(pickedFile.path);
    print('Image picked: ${pickedFile.path}');
    checkImageSize(imageFile!);
  } else {
    print('No image selected.');
  }
}

void checkImageSize(File imageFile) {
  try {
    print("Checking image size...");

    // Get the file size in bytes
    int fileSizeInBytes = imageFile.lengthSync();

    // Convert to kilobytes (KB)
    double fileSizeInKB = fileSizeInBytes / 1024;

    // Convert to megabytes (MB)
    double fileSizeInMB = fileSizeInKB / 1024;

    // Print the size in KB and MB
    print('Image Size: ${fileSizeInKB.toStringAsFixed(2)} KB');
    print('Image Size: ${fileSizeInMB.toStringAsFixed(2)} MB');

    // Set a size limit (e.g., 2 MB)
    if (fileSizeInMB > 2) {
      print('The image is too large! Resizing image...');
      resizeImage(imageFile);  // Resize image if it's too large
    } else {
      print('Image is within the acceptable size.');
    }
  } catch (e) {
    print('Error checking image size: $e');
  }
}

Future<void> resizeImage(File imageFile) async {
  try {
    // Read the image file
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

    if (image != null) {
      // Resize the image (example: resize to 800x800 or any dimensions you prefer)
      img.Image resized = img.copyResize(image, width: 400, height: 400);

      // Save the resized image
      File resizedFile = File(imageFile.path)..writeAsBytesSync(img.encodeJpg(resized));

      print('Resized image saved to: ${resizedFile.path}');
      // Now, you can upload the resized image or use it as needed
    } else {
      print('Error decoding image.');
    }
  } catch (e) {
    print('Error resizing image: $e');
  }
}

  void _verifyPayment() {
    setState(() {
      paymentStatus = 'Completed';
    });
  }

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
                  onNavigate: () => recordDonation(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget buildImagePickerSection() {
    return Column(
      children: [
        const Text(
          'Upload Payment Screenshot:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        imageFile == null
            ? const Text('No image selected.')
            : Image.file(imageFile!, height: 300, width: 300, fit: BoxFit.cover),
        const SizedBox(height: 10),
        Center(
          child: CustomButton(
            title: "Choose Image",
            icon: Icons.camera_alt,
            onNavigate: _pickImage,
          ),
        ),
      ],
    );
  }

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
