import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:sadqahzakat/Screens/Login/Screen/login_page.dart';
import 'package:sadqahzakat/components/custom_button.dart';
import 'package:sadqahzakat/model/payment_detail.dart';

const storage = FlutterSecureStorage();

class PaymentMethod extends StatefulWidget {
  final String? placeholderText;
  final String? donationtitle;
  final String? iszakat;
  final String? issadqah;
  final String? amount;
  final String? age;
  final String? gender;
  final String? headingcategory;
  final String? selectcategory;
  final String? quantity;
  const PaymentMethod({
    super.key,
    required this.placeholderText,
    required this.donationtitle,
    required this.iszakat,
    required this.issadqah,
    required this.amount,
    required this.quantity,
    required this.age,
    required this.gender,
    required this.headingcategory,
    required this.selectcategory,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  File? imageFile;
  late Future<String> paymentStatus;
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  // bool isLoading = true;
  bool isUpdating = false;
  String errorMessage = '';
  @override
  void initState() {
    super.initState();
    paymentStatus = fetchPaymentStatus();
    _checkAccessToken();
  }

  // Fetch Payment Status
  Future<String> fetchPaymentStatus() async {
    try {
      String? donorId = await storage.read(key: 'user_id');
      final response = await http.get(
        Uri.parse(
            'https://sadqahzakaat.com/data/donor-history/$donorId/status/'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['payment_status'] ?? 'Unknown';
      }
      return 'Failed to load status';
    } catch (e) {
      return 'Error: $e';
    }
  }

  double _calculateTotalP() {
    // Convert placeholderText to double
    final double subtotal =
        double.tryParse(widget.placeholderText.toString()) ?? 0.9;
    const double taxRate = 0.05; // 5% tax

    // Calculate total
    final double total = subtotal + (subtotal * taxRate);

    return total;
  }

  Future<PaymentDetail?> recordDonation() async {
    String title = widget.donationtitle!;
    List<String> donationList = title.split(',').map((e) => e.trim()).toList();
    List<bool> issadqahList = widget.issadqah!
        .split(',')
        .map((value) => value.trim() == 'true')
        .toList();
    List<bool> iszakatList = widget.iszakat!
        .split(',')
        .map((value) => value.trim() == 'true')
        .toList();
    List<double> convertedValues = widget.amount!
        .split(',')
        .map((value) => double.tryParse(value.trim()) ?? 0.0)
        .toList();
    List<double> convertedQuantity = widget.quantity!
        .split(',')
        .map((value) => double.tryParse(value.trim()) ?? 0.0)
        .toList();
    String headcategory = widget.headingcategory!;
    List<String> headcategoryList =
        headcategory.split(',').map((e) => e.trim()).toList();
    String gen = widget.gender!;
    List<String> genList = gen.split(',').map((e) => e.trim()).toList();
    String agecheck = widget.age!;
    List<String> agecheckList =
        agecheck.split(',').map((e) => e.trim()).toList();
    String scategory = widget.selectcategory!;
    List<String> scategoryList =
        scategory.split(',').map((e) => e.trim()).toList();

    try {
      String? token = await storage.read(key: 'access_token');
      // String? donorName = await storage.read(key: 'user_name');
      // String? donorId = await storage.read(key: 'user_id');
      String? Email = await storage.read(key: 'email');
      print(Email);
      print(token);
      print(nameController.text);
      print(userIdController.text);
      // print(token);
      if ([token].contains(null)) {
        showMessage('Error: Missing user details.');
        return null;
      }

      final payload = {
        "donor_name": nameController.text,
        "donor_id": userIdController.text,
        "email": Email,
        "is_zakat": iszakatList.map((isZakat) => {"isZakat": isZakat}).toList(),
        "is_sadqah":
            issadqahList.map((isSadqah) => {"isSadqah": isSadqah}).toList(),
        "donationtitle": donationList
            .map((donationtitle) => {"donationtitle": donationtitle})
            .toList(),
        "donations":
            convertedValues.map((amount) => {"amount": amount}).toList(),
        "donations1": convertedQuantity
            .map((quantity) => {"quantity": quantity})
            .toList(),
        "headingcategory": headcategoryList
            .map((headingcategory) => {"headingcategory": headingcategory})
            .toList(),
        "gender": genList.map((gender) => {"gender": gender}).toList(),
        "age": agecheckList.map((age) => {"age": age}).toList(),
        "selectcategory": scategoryList
            .map((selectcategory) => {"selectcategory": selectcategory})
            .toList(),
      };
      // print(payload);
      // Create a MultipartRequest
      final request = http.MultipartRequest(
        'POST',
        // Uri.parse('https://sadqahzakaat.com/data/donor-history/'),
        Uri.parse('https://sadqahzakaat.com/data/donor-history/'),
      )
        ..headers['Authorization'] = 'JWT $token'
        ..fields['data'] = jsonEncode(payload); // Add JSON payload as a field

      // Add image file if it exists
      if (imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'payment_image',
          imageFile!.path,
        ));
      }

      // Send the request
      final response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        _showSuccessDialog();
        final responseBody = await response.stream.bytesToString();
        showMessage('Donation recorded successfully');
        return PaymentDetail.fromJson(jsonDecode(responseBody));
      } else {
        final errorBody = await response.stream.bytesToString();
        showMessage(
            'Failed to record donation. Code: ${response.statusCode}, Body: $errorBody');
        print("Body: $errorBody");
      }
    } catch (e) {
      showMessage('Error: $e');
    }
    return null;
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Your donation has been successfully done.'),
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

  void _showloginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text(
            'Please log in to access and submit the donation request form.'),
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

  // Pick and Process Image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() => imageFile = File(pickedFile.path));
      await checkImageSize(imageFile!);
    } else {
      showMessage('No image selected.');
    }
  }

  Future<void> checkImageSize(File image) async {
    final fileSizeMB = image.lengthSync() / (1024 * 1024);
    if (fileSizeMB > 2) {
      await resizeImage(image);
    } else {
      uploadImage();
    }
  }

  Future<void> resizeImage(File image) async {
    try {
      final decodedImage = img.decodeImage(image.readAsBytesSync());
      if (decodedImage != null) {
        final resizedImage = img.copyResize(decodedImage, width: 400);
        final resizedFile = File(image.path)
          ..writeAsBytesSync(img.encodeJpg(resizedImage));
        setState(() => imageFile = resizedFile);
        uploadImage();
      }
    } catch (e) {
      showMessage('Error resizing image: $e');
    }
  }

  void uploadImage() {
    showMessage('Image ready for upload.');
  }

  // Show Snackbar
  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  // UI Components
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
                  Text('Account Number: $accountNumber'),
                  Text('Bank Name: $bankName'),
                  Text('Account Holder: $accountHolder'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Payment Screenshot:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        imageFile == null
            ? const Text('No image selected.')
            : Image.file(imageFile!, height: 300, fit: BoxFit.cover),
        const SizedBox(height: 10),
        Center(
          child: CustomButton(
            title: "Choose Image",
            icon: FontAwesomeIcons.image,
            onNavigate: _pickImage,
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget buildPaymentStatus() {
    return FutureBuilder<String>(
      future: paymentStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final status = snapshot.data ?? 'Unknown';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Status:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 16,
                  color: status == 'Completed' ? Colors.green : Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
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
              const SizedBox(height: 20),
              _buildRow('Subtotal', "Rs. ${widget.placeholderText.toString()}"),
              const SizedBox(height: 10),
              _buildRow('Taxes', "5%"), // Assuming no taxes for donations
              const Divider(thickness: 4.0, height: 30.0, color: Colors.black),
              _buildRow(
                'Total',
                "Rs. ${_calculateTotalP()}",
                isBold: true,
              ),
              const SizedBox(height: 10),
              // ValueReader(widget.placeholderText.toString()),
              const SizedBox(height: 30),
              buildImagePicker(),
              const SizedBox(height: 20),
              buildPaymentStatus(),
              const SizedBox(height: 20),
              Center(
                child: CustomButton(
                  title: "Verify Payment",
                  icon: FontAwesomeIcons.moneyCheck,
                  onNavigate: recordDonation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
