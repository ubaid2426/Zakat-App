import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sadqahzakat/Screens/PaymentMethod/payment_method.dart';
import 'package:sadqahzakat/Screens/cart/cartScreen.dart';
import 'package:sadqahzakat/components/custom_button.dart';
import 'package:sadqahzakat/model/donate_model.dart';

class Data extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double? projectvalue;
  final double? paidvlaue;
  // final VoidCallback onComplete;
  const Data({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.projectvalue,
    required this.paidvlaue,
    // required this.onComplete,
  });

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  final TextEditingController _controller = TextEditingController(text: "32");
  double donationAmount = 32.0;
  // print(TextEditingController);
  bool isSelected = false;
  bool isZakat = false;
  bool isSadah = false;

  @override
  Widget build(BuildContext context) {
    //  print(_controller);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(19, 19, 19, 0),
        child: Container(
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
            children: [
              const SizedBox(height: 30),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 26,
                  decoration: TextDecoration.none,
                  fontFamily: "Roboto",
                  color: Color(0xFF7fc23a),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const Divider(
                color: Color(0xFF7fc23a),
                thickness: 4,
                indent: 50,
                endIndent: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 88, 88, 88),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(
                        "http://127.0.0.1:8000/data${widget.imageUrl}"),
                    fit: BoxFit.cover,
                  ),
                ),

                //  Image.asset(
                //   widget.imageUrl,
                //   fit: BoxFit.cover,
                // ),
              ),
              const SizedBox(height: 10),
              buildProjectDetails(), // Use updated method for project details
              const SizedBox(height: 10),
              buildProgressIndicator(), // Progress indicator for donation
              // const SizedBox(height: 20),
              buildDonationSection(), // Donation input
              // const SizedBox(height: 20),
              buildZakatCheckBox(), // Checkbox for Zakat
              const SizedBox(height: 10),
              buildSadahCheckBox(),
              const SizedBox(height: 10),
              buildSecureDonation(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for displaying project info
  Widget buildProjectDetails() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 237, 228, 228),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildProjectInfo(
              'Rs ${widget.projectvalue?.toInt()}', 'Project value'),
          buildProjectInfo('${widget.paidvlaue?.toInt()}', 'Paid'),
          buildProjectInfo(
              'Rs ${(widget.projectvalue! - widget.paidvlaue!).toInt()}',
              'Remaining'),
        ],
      ),
    );
  }

  // Reusable project info widget
  Widget buildProjectInfo(String value, String label) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 237, 228, 228),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 128, 126, 126),
                fontFamily: "Montserrat",
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Build the Zakat checkbox
  Widget buildZakatCheckBox() {
    return Row(
      children: [
        Checkbox(
          value: isZakat,
          onChanged: (bool? value) {
            setState(() {
              isZakat = value ?? false;
            });
          },
        ),
        const Text("This Donation is Zakat"),
      ],
    );
  }

  Widget buildSadahCheckBox() {
    return Row(
      children: [
        Checkbox(
          value: isSadah,
          onChanged: (bool? value) {
            setState(() {
              isSadah = value ?? false;
            });
          },
        ),
        const Text("This Donation is Saqah"),
      ],
    );
  }

  // Donation input section with buttons
  Widget buildDonationSection() {
    double progress = widget.paidvlaue! / widget.projectvalue!;
    double donationAmount = double.tryParse(_controller.text) ?? 30.0;
    if (progress >= 1.0) {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: CustomButton(
          title: "Donation Complete",
          icon: FontAwesomeIcons.checkDouble,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
      child: Column(
        children: [
          const Text(
            "Enter Donation Amount (\$)",
            style: TextStyle(
              fontSize: 12.0,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Material(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() {
                  // Update donationAmount as user types
                  donationAmount = double.tryParse(value) ?? 32.0;
                });
              },
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                title: "Donate",
                icon: FontAwesomeIcons.circleDollarToSlot,
                //  double donationAmount = double.tryParse(_controller.text) ?? 32.0,
                navigateTo: PaymentMethod(
                  placeholderText: donationAmount.toString(),
                  donationtitle: widget.title,
                  iszakat: isZakat.toString(),
                  issadqah: isSadah.toString(), quantity: '',
                  amount: donationAmount.toString(),
                  // placeholderText: donationamount.tryParse(_controller.text),
                ),
              ),
              buildAddToCartButton(),
            ],
          ),
        ],
      ),
    );
  }

  // Add to cart button
  Widget buildAddToCartButton() {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });

        int donationAmount = int.parse(_controller.text);
        DonateModel donation = DonateModel(
          id: 'donation_${controller.cartFood.length + 1}',
          title: widget.title,
          des: widget.description,
          image: widget.imageUrl,
          route: '/donation',
          price: donationAmount,
          isZakat: isZakat,
          isSadqah: isSadah,
          quantity: null,
        );

        // Add donation to cart
        controller.addToCart(donation);
      },
      splashColor: const Color(0xFF7fc23a),
      child: Container(
        width: MediaQuery.of(context).size.width /2 -40,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7fc23a) : Colors.white,
          border: Border.all(color: const Color(0xFF7fc23a)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Add To Cart",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            Icon(
              FontAwesomeIcons.cartShopping,
              color: isSelected ? Colors.white : Colors.black,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  // Secure donation section
  Widget buildSecureDonation() {
    return Container(
      height: 50,
      color: const Color(0xFFF1F1F1),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock, color: Color.fromARGB(72, 81, 75, 75)),
          SizedBox(width: 10),
          Text(
            ' Secure Donation',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  // Progress indicator widget
  Widget buildProgressIndicator() {
    double progress = widget.paidvlaue! / widget.projectvalue!;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF7fc23a)),
            minHeight: 10,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '${(progress * 100).toInt()}%',
          style: const TextStyle(
            fontSize: 16,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
