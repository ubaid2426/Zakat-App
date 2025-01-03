import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/blood_donation/blood_donation.dart';
// import 'package:sadqahzakat/Screens/PaymentMethod/payment_method.dart';
// import 'package:sadqahzakat/Screens/cart/cartScreen.dart';
// import 'package:sadqahzakat/components/map_main.dart';
// import 'package:sadqahzakat/model/donate_model.dart';
// import 'package:sadqahzakat/model/donate_model.dart';

class BloodCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String screentitle;
  final String description;
  final double? projectvalue;
  final double? paidvlaue;
  final String selectcategory;
  final String address;
  final double latitude;
  final double longitude;
  const BloodCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.projectvalue,
    required this.paidvlaue,
    required this.selectcategory,
    required this.screentitle,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  _BloodCardState createState() => _BloodCardState();
}

class _BloodCardState extends State<BloodCard> {
  final TextEditingController _donationController =
      TextEditingController(text: "1");
  bool isSelected = false;
  bool isZakat = false;
  bool isSadah = false;
  int totalDonationAmount = 0;
  String cityName = 'Loading...';
  @override
  void initState() {
    super.initState();
    _fetchCityName(widget.latitude, widget.longitude);
  }
  // This is the method to get city name from coordinates
  Future<void> _fetchCityName(double latitude, double longitude) async {
    String city = await getCityName(latitude, longitude);
    setState(() {
      cityName = city; // Update cityName after fetching
    });
  }
  // Map<String, dynamic>? selectedDonation;
  Future<String> getCityName(double latitude, double longitude) async {
    try {
      // Get the list of placemarks from the latitude and longitude
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      // Get the city from the placemarks
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        return placemark.locality ?? 'Unknown city';
      } else {
        return 'City not found';
      }
    } catch (e) {
      print('Error occurred: $e');
      return 'Error getting city name';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.screentitle,
            style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF7fc23a),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImageSection(),
              // const SizedBox(height: 16),
              buildTitleAndDescription(),
              const SizedBox(height: 10),
              buildAddress(),
              const SizedBox(height: 10),
              buildProjectDetails(),
              const SizedBox(height: 10),
              buildProgressIndicator(),
              const SizedBox(height: 10),
              buildDonationInput(),
              const SizedBox(height: 10),
              // buildDonationTypeCheckboxes(),
              // const SizedBox(height: 10),
              buildActions(),
              const SizedBox(height: 10),
              buildSecureDonationFooter(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        "https://sadqahzakaat.com${widget.imageUrl}",
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildTitleAndDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7fc23a),
          ),
        ),
        const SizedBox(height: 8),
        ExpandableText(
          widget.description,
          trimType: TrimType.lines,
          trim: 2,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget buildProjectDetails() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 6),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildDetailItem(
              'Required', ' ${widget.projectvalue?.toInt()}'),
          buildDetailItem('Get', ' ${widget.paidvlaue?.toInt()}'),
          buildDetailItem('Remaining',
              ' ${(widget.projectvalue! - widget.paidvlaue!).toInt()}'),
        ],
      ),
    );
  }

  Widget buildDetailItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget buildProgressIndicator() {
    double progress = widget.paidvlaue! / widget.projectvalue!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation(Color(0xFF7fc23a)),
          minHeight: 10,
        ),
        const SizedBox(height: 8),
        Text(
          'Progress: ${(progress * 100).toInt()}%',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget buildDonationInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How Much Bottle you wanna give!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _donationController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            suffixText: '',
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget buildAddress() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: ListTile(
        leading: Icon(Icons.location_on, color: Color(0xFF7fc23a)),
        title:
            Text(cityName, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(widget.address),
        onTap: () {
          print("button press location");
          // When the card is tapped, navigate to the LocationScreen with latitude and longitude
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => LocationScreen(
          //       latitude: widget.latitude,
          //       longitude: widget.latitude,
          //       address: address,
          //     ),
          //   ),
          // );
        },
      ),
    );
  }

  // Widget buildDonationTypeCheckboxes() {
  //   return Column(
  //     children: [
  //       buildCheckbox(
  //         label: "This Donation is Zakat",
  //         value: isZakat,
  //         onChanged: (value) {
  //           setState(() {
  //             isZakat = value!;
  //             if (value) isSadah = false;
  //           });
  //         },
  //       ),
  //       buildCheckbox(
  //         label: "This Donation is Sadah",
  //         value: isSadah,
  //         onChanged: (value) {
  //           setState(() {
  //             isSadah = value!;
  //             if (value) isZakat = false;
  //           });
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget buildCheckbox(
  //     {required String label,
  //     required bool value,
  //     required Function(bool?) onChanged}) {
  //   return Row(
  //     children: [
  //       Checkbox(
  //         value: value,
  //         activeColor: const Color(0xFF7fc23a),
  //         onChanged: onChanged,
  //       ),
  //       Text(label, style: const TextStyle(fontSize: 14)),
  //     ],
  //   );
  // }

  Widget buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BloodDonationForm(selectedCategory: _donationController.text)
                ),
              );
            },
            icon: const Icon(FontAwesomeIcons.donate),
            label: const Text('Donate Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7fc23a),
              padding: const EdgeInsets.all(12),
            ),
          ),
        ),
        // const SizedBox(width: 16),
        // Expanded(
        //   child: OutlinedButton.icon(
        //     onPressed: () {
        //       int donationAmount = int.parse(_donationController.text);
        //       print('press it');
        //       if (donationAmount != null && donationAmount > 0) {
        //         setState(() {
        //           isSelected = !isSelected;
        //         });

        //         DonateModel donation = DonateModel(
        //           id: 'donation_${controller.cartFood.length + 1}',
        //           title: widget.title,
        //           des: widget.description,
        //           image: widget.imageUrl,
        //           route: '/donation',
        //           price: donationAmount,
        //           isZakat: isZakat,
        //           isSadqah: isSadah,
        //           quantity: 0,
        //           age: '',
        //           gender: '',
        //           headingcategory: 'dynamic',
        //           selectcategory: widget.selectcategory,
        //         );

        //         controller.addToCart(donation);
        //       }
        //     },
        //     icon: Icon(
        //       FontAwesomeIcons.cartPlus,
        //       color: isSelected ? Colors.white : const Color(0xFF7fc23a),
        //     ),
        //     label: Text(
        //       isSelected ? 'Added to Cart' : 'Add to Cart',
        //       style: TextStyle(
        //           color: isSelected ? Colors.white : const Color(0xFF7fc23a)),
        //     ),
        //     style: OutlinedButton.styleFrom(
        //       side: const BorderSide(color: Color(0xFF7fc23a)),
        //       backgroundColor:
        //           isSelected ? const Color(0xFF7fc23a) : Colors.white,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget buildSecureDonationFooter() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Colors.grey[100],
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock, color: Colors.grey),
          SizedBox(width: 8),
          Text('Secure Donation', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
