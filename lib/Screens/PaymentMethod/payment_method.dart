import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:zakat_app/Screens/PaymentMethod/value_reader.dart';
import 'package:zakat_app/components/custom_button.dart';
import 'package:zakat_app/model/payment_detail.dart';
import 'package:image/image.dart' as img;

const storage = FlutterSecureStorage();

class PaymentMethod extends StatefulWidget {
  final double? placeholderText;
  final String? donationtitle;
  final bool? iszakat;
  final bool? issadqah;
  const PaymentMethod(
      {super.key, required this.placeholderText, required this.donationtitle, required this.iszakat, required this.issadqah});

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  File? imageFile;
  late Future<String> paymentStatus;
  bool showSpinner = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    paymentStatus = Future.value('Pending');
    fetchPaymentStatus();
  }

  Future<String> fetchPaymentStatus() async {
    String? donorId = await storage.read(key: 'user_id');
    final url =
        Uri.parse('http://127.0.0.1:8000/data/donor-history/$donorId/status/');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['payment_status'];
    } else {
      throw Exception('Failed to load payment status');
    }
  }

  Future<PaymentDetail?> recordDonation() async {
    PaymentDetail? paymentDetail;
    String? token = await storage.read(key: 'access_token');
    String? donorName = await storage.read(key: 'user_name');
    String? donorId = await storage.read(key: 'user_id');

    if (token == null || donorName == null || donorId == null) {
      showMessage('Error: Missing token or user details.');
      return null;
    }

    final uri = Uri.parse('http://127.0.0.1:8000/data/donor-history/');
    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'JWT $token'
      ..fields['donor_name'] = donorName
      ..fields['donor_id'] = donorId
      ..fields['is_zakat'] = widget.iszakat.toString()
      ..fields['is_sadqah'] = widget.issadqah.toString()
      ..fields['amount'] = (widget.placeholderText ?? 0.0).toString()
      ..fields['donation_title'] = widget.donationtitle ?? '';

    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'payment_image',
        imageFile!.path,
      ));
    }

    try {
      setState(() => showSpinner = true);
      final response = await request.send();

      if (response.statusCode == 200) {
        showMessage('ScreenShot is Loaded successfully');
        final responseBody = await response.stream.bytesToString();
        paymentDetail = PaymentDetail.fromJson(json.decode(responseBody));
      } else {
        showMessage(
            'Failed to record donation. Status code: ${response.statusCode}');
      }
    } catch (e) {
      showMessage('Error: $e');
    } finally {
      setState(() => showSpinner = false);
    }

    return paymentDetail;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      setState(() => imageFile = File(pickedFile.path));
      checkImageSize(imageFile!);
    } else {
      showMessage('No image selected.');
    }
  }

  void checkImageSize(File imageFile) async {
    final fileSizeInMB = imageFile.lengthSync() / (1024 * 1024);

    if (fileSizeInMB > 2) {
      await resizeImage(imageFile);
    } else {
      uploadImage();
    }
  }

  Future<void> resizeImage(File imageFile) async {
    try {
      final image = img.decodeImage(imageFile.readAsBytesSync());
      if (image != null) {
        final resized = img.copyResize(image, width: 400, height: 400);
        final resizedFile = File(imageFile.path)
          ..writeAsBytesSync(img.encodeJpg(resized));
        setState(() => this.imageFile = resizedFile);
        uploadImage();
      }
    } catch (e) {
      showMessage('Error resizing image: $e');
    }
  }

  Future<void> uploadImage() async {
    if (imageFile == null) return;
    await recordDonation();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
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
                  onNavigate: recordDonation,
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
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Account Number: $accountNumber',
                      style: const TextStyle(fontSize: 16)),
                  Text('Bank Name: $bankName',
                      style: const TextStyle(fontSize: 16)),
                  Text('Account Holder: $accountHolder',
                      style: const TextStyle(fontSize: 16)),
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
            : Image.file(imageFile!,
                height: 300, width: 300, fit: BoxFit.cover),
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

  Widget buildPaymentStatus() {
    return FutureBuilder<String>(
      future: paymentStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
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
                  snapshot.data!,
                  style: TextStyle(
                    fontSize: 16,
                    color: snapshot.data == 'Completed'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Text('No data available.');
        }
      },
    );
  }
}
