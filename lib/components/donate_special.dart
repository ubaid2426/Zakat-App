import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sadqahzakat/Screens/PaymentMethod/payment_method.dart';
import 'package:sadqahzakat/components/CounterButton/counter_button.dart';
import 'package:sadqahzakat/components/custom_button.dart';
import 'package:sadqahzakat/controller/controller.dart';
import 'package:sadqahzakat/model/donate_model.dart';

class DataSpecial extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double? projectvalue;
  final double? paidvlaue;
  final String selectcategory;
  final List<Map<String, dynamic>>? donationOptions;
  const DataSpecial({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.projectvalue,
    required this.paidvlaue,
    required this.donationOptions,
    required this.selectcategory,
  });

  @override
  State<DataSpecial> createState() => _DataSpecialState();
}

class _DataSpecialState extends State<DataSpecial> {
  final FoodController controller = Get.put(FoodController());
  final TextEditingController _controller = TextEditingController();
  bool isSelected = false;
  bool isZakat = false;
  bool isSadah = false;
  late double? projectValue;
  late double? paidValue;
  int quantity = 1;
  int totalDonationAmount = 0;
  double donationAmount = 32.0;
  // Dropdown state
  Map<String, dynamic>? selectedDonation;
  // final List<Map<String, dynamic>> donationOptions = [
  //   {'title': 'Food Donation', 'price': 100},
  //   {'title': 'Clothes Donation', 'price': 50},
  //   {'title': 'Health Donation', 'price': 150},
  //   {'title': 'Education Donation', 'price': 200},
  // ];
  // List<Map<String, dynamic>> donationOptions = getDonationOptions();

  // for (var donation in donationOptions) {
  //   print('Title: ${donation['title']}, Price: ${donation['price']}');
  // }
  @override
  void initState() {
    super.initState();
    projectValue = widget.projectvalue;
    paidValue = widget.paidvlaue;
    _controller.text = totalDonationAmount.toString();
  }

  void updateTotalAmount() {
    if (selectedDonation != null) {
      setState(() {
        totalDonationAmount = (selectedDonation!['price'] as int) * quantity;
        _controller.text = totalDonationAmount.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        Padding(
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
              child: ExpandableText(
                widget.description,
                trimType: TrimType.lines,
                trim: 2,
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
            const SizedBox(height: 20),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://sadqahzakaat.com/data${widget.imageUrl}"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            buildProjectDetails(),
            const SizedBox(height: 20),
            buildProgressIndicator(),
            const SizedBox(height: 20),
            buildDonationDropdown(),
            // const SizedBox(height: 20),
            buildDonationSection(),
            // const SizedBox(height: 20),
            // buildZakatCheckBox(),
            // const SizedBox(height: 20),
            buildSecureDonation(),
          ],
        ),
      ),
      // ),
    );
  }

  Widget buildDonationSection() {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const Text(
              "Enter Donation Amount (\$)",
              style: TextStyle(
                fontSize: 14.0,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            // Counter for Quantity
            GetBuilder<FoodController>(
              builder: (foodController) {
                return CounterButton(
                  onIncrementSelected: () {
                    setState(() {
                      quantity++;
                      updateTotalAmount();
                    });
                  },
                  onDecrementSelected: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                        updateTotalAmount();
                      });
                    }
                  },
                  label: Text(
                    quantity.toString(),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                );
              },
            ),
            // const SizedBox(height: 10.0),
            // Read-only text field displaying price * quantity
            TextField(
              controller: _controller,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Total Donation Amount (Rs)",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  // Update donationAmount as user types
                  donationAmount = double.tryParse(value) ?? 32.0;
                });
              },
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  title: "Donate",
                  icon: FontAwesomeIcons.circleDollarToSlot,
                  navigateTo: PaymentMethod(
                    // placeholderText: double.tryParse(_controller.text) ?? 32.0,
                    placeholderText: (_controller.text),
                    donationtitle: widget.title, iszakat: isZakat.toString(),
                    issadqah: isSadah.toString(),
                    amount: _controller.text,
                    quantity: (quantity.toString()),
                    headingcategory: 'static',
                    age: '',
                    gender: '',
                    selectcategory: widget.selectcategory,
                  ),
                ),
                buildAddToCartButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddToCartButton() {
    return Material(
      child: InkWell(
        onTap: () {
          if (selectedDonation != null && totalDonationAmount > 0) {
            setState(() {
              isSelected = !isSelected;
            });

            DonateModel donation = DonateModel(
              id: 'donation_${controller.cartFood.length + 1}',
              title: widget.title,
              des: widget.description,
              image: widget.imageUrl,
              route: '/donation',
              price: totalDonationAmount,
              isZakat: isZakat,
              isSadqah:isSadah,
              quantity: quantity,
              age: '',
              gender: '',
              headingcategory: 'static',
              selectcategory: widget.selectcategory,
            );

            controller.addToCart(donation);
          }
        },
        splashColor: const Color(0xFF7fc23a),
        child: Container(
          width: MediaQuery.of(context).size.width / 2 - 40,
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
      ),
    );
  }

  Widget buildDonationDropdown() {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Text(
              'Select a donation option:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Container(
              color: const Color(0xFF7fc23a),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<Map<String, dynamic>>(
                isExpanded: true,
                hint: const Text(
                  'Choose a donation option',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                value: selectedDonation,
                items:
                    widget.donationOptions!.map((Map<String, dynamic> option) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: option,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(option['title']),
                        Text('Rs ${option['price']}'),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (Map<String, dynamic>? newValue) {
                  setState(() {
                    selectedDonation = newValue;
                    updateTotalAmount(); // Recalculate total donation amount
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildDonationDropdown() {
  //   return Material(
  //     color: Colors.white,

  //     //  background-color:Colors.green,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //       child: Column(
  //         children: [
  //           const Text(
  //             'Select a donation option:',
  //             style: TextStyle(fontSize: 18),
  //           ),
  //           const SizedBox(height: 10),
  //           Container(
  //             color: const Color(0xFF7fc23a),
  //             padding: const EdgeInsets.symmetric(
  //                 horizontal: 12), // Optional padding
  //             child: DropdownButton<Map<String, dynamic>>(
  //               // dropdownColor: Colors.red,
  //               isExpanded: true,
  //               hint: const Text(
  //                 'Choose a donation option',
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                 ),
  //               ),
  //               value: selectedDonation,
  //               items: donationOptions.map((Map<String, dynamic> option) {
  //                 return DropdownMenuItem<Map<String, dynamic>>(
  //                   value: option,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(option['title']),
  //                       Text('Rs ${option['price']}'),
  //                     ],
  //                   ),
  //                 );
  //               }).toList(),
  //               onChanged: (Map<String, dynamic>? newValue) {
  //                 setState(() {
  //                   selectedDonation = newValue;
  //                   updateTotalAmount(); // Recalculate total donation amount
  //                 });
  //               },
  //             ),
  //           ),
  //           // const SizedBox(height: 10),
  //           // if (selectedDonation != null)
  //           // Text(
  //           //   'Selected Donation: ${selectedDonation!['title']} for Rs ${selectedDonation!['price']}',
  //           //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //           // ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget buildSecureDonation() {
    return Container(
      height: 70,
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

  Widget buildProgressIndicator() {
    double progress = paidValue! / projectValue!;
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
            fontWeight: FontWeight.bold,
            color: Color(0xFF7fc23a),
          ),
        ),
      ],
    );
  }

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
          buildProjectInfo(' ${projectValue!.toInt()}', 'How much'),
          buildProjectInfo('${paidValue!.toInt()}', 'Added'),
          buildProjectInfo(' ${(projectValue! - paidValue!).toInt()}', 'Left'),
        ],
      ),
    );
  }

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
                fontSize: 16,
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
}
