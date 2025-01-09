import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sadqahzakat/Screens/PaymentMethod/payment_method.dart';
import 'package:sadqahzakat/components/CounterButton/counter_button.dart';
import 'package:sadqahzakat/components/custom_button.dart';
import 'package:sadqahzakat/controller/controller.dart';
import 'package:sadqahzakat/model/donate_model.dart';

class StaticOtherDesign extends StatefulWidget {
  final String imageUrl;
  final String description;
  final List<Map<String, dynamic>>? donationOptions;
  final String selectcategory;
  final String title;

  const StaticOtherDesign({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.donationOptions,
    required this.selectcategory,
    required this.title,
  });

  @override
  State<StaticOtherDesign> createState() => _StaticOtherDesignState();
}

class _StaticOtherDesignState extends State<StaticOtherDesign> {
  final FoodController controller = Get.put(FoodController());
  final TextEditingController _controller = TextEditingController();
  bool isSelected = false;
  bool isZakat = false;
  bool isSadah = false;
  int quantity = 1;
  int totalDonationAmount = 0;

  Map<String, dynamic>? selectedDonation;

  void updateTotalAmount() {
    if (selectedDonation != null) {
      setState(() {
        totalDonationAmount = (selectedDonation!['price'] as int) * quantity;
        _controller.text = totalDonationAmount.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.text = totalDonationAmount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
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
              buildHeader(),
              buildImageSection(),
              _buildDonationDropdown(),
              const SizedBox(height: 15),
              buildDonationSection(),
              const SizedBox(height: 15),
              buildCheckboxRow(),
              const SizedBox(height: 15),
              buildSecureDonation(),
              const SizedBox(height: 15),
              buildActionButtons(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ExpandableText(
        widget.description,
        trimType: TrimType.lines,
        trim: 2,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildImageSection() {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        // backgr
        // color: Colors.red,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(widget.imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }

  // Widget _buildDonationDropdown() {
  //   return Material(
  //     color: Colors.transparent,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Text(
  //             'Select a donation option:',
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black87,
  //             ),
  //           ),
  //           const SizedBox(height: 12),
  //           Container(
  //             decoration: BoxDecoration(
  //               gradient: const LinearGradient(
  //                 colors: [
  //                   Color(0xFF7fc23a),
  //                   Color.fromARGB(255, 145, 191, 100)
  //                 ],
  //                 begin: Alignment.topLeft,
  //                 end: Alignment.bottomRight,
  //               ),
  //               borderRadius: BorderRadius.circular(16),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.4),
  //                   spreadRadius: 2,
  //                   blurRadius: 10,
  //                   offset: const Offset(0, 3),
  //                 ),
  //               ],
  //             ),
  //             child: Padding(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //               child: Row(
  //                 children: [
  //                   const Icon(
  //                     Icons.volunteer_activism,
  //                     color: Colors.white,
  //                     size: 30,
  //                   ),
  //                   const SizedBox(width: 10),
  //                   Expanded(
  //                     child: DropdownButtonHideUnderline(
  //                       child: DropdownButton<Map<String, dynamic>>(
  //                         isExpanded: true,
  //                         hint: const Text(
  //                           'Choose a donation option',
  //                           style:
  //                               TextStyle(fontSize: 16, color: Colors.white70),
  //                         ),
  //                         value: selectedDonation,
  //                         items: widget.donationOptions!
  //                             .map((option) =>
  //                                 DropdownMenuItem<Map<String, dynamic>>(
  //                                   value: option,
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                       Text(
  //                                         option['title'],
  //                                         style: const TextStyle(
  //                                           fontSize: 16,
  //                                           color: Colors.white,
  //                                         ),
  //                                       ),
  //                                       Text(
  //                                         'Rs ${option['price']}',
  //                                         style: const TextStyle(
  //                                           fontSize: 16,
  //                                           fontWeight: FontWeight.bold,
  //                                           color: Colors.white,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ))
  //                             .toList(),
  //                         onChanged: (newValue) {
  //                           setState(() {
  //                             selectedDonation = newValue;
  //                             // ageTitle = selectedDonation?['title'];
  //                             updateTotalAmount();
  //                           });
  //                         },
  //                         icon: const Icon(
  //                           Icons.arrow_drop_down,
  //                           color: Colors.white,
  //                         ),
  //                         dropdownColor: const Color(0xFF7fc23a),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
Widget _buildDonationDropdown() {
  return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a donation option:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7fc23a), Color.fromARGB(255, 145, 191, 100)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Icon(
                      Icons.volunteer_activism,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<Map<String, dynamic>>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF7fc23a),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        hint: const Text(
                          'Choose a donation option',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        value: selectedDonation,
                        items: widget.donationOptions?.map((option) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: option,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  option['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Rs ${option['price']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedDonation = newValue;
                          });
                          // widget.onDonationSelected(newValue);
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        dropdownColor: const Color(0xFF7fc23a),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
}

  // Widget buildDonationDropdown() {
  //   return Material(
  //     elevation: 2,
  //     borderRadius: BorderRadius.circular(12),
  //     color: Colors.white,
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Container(
  //         color: const Color(0xFF7fc23a),
  //         padding: const EdgeInsets.symmetric(horizontal: 12),
  //         child: DropdownButton<Map<String, dynamic>>(
  //           isExpanded: true,
  //           value: selectedDonation,
  //           hint: const Text('Select a donation option'),
  //           items: widget.donationOptions?.map((option) {
  //             return DropdownMenuItem<Map<String, dynamic>>(
  //               value: option,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(option['title']),
  //                   Text('Rs ${option['price']}'),
  //                 ],
  //               ),
  //             );
  //           }).toList(),
  //           onChanged: (newValue) {
  //             setState(() {
  //               selectedDonation = newValue;
  //               updateTotalAmount();
  //             });
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildDonationSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter Donation Amount (\$)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CounterButton(
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
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                width: 150,
                child: TextField(
                  controller: _controller,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Total Donation (Rs)",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCheckboxRow() {
    return Column(
      children: [
        CheckboxListTile(
          activeColor: Colors.green,
          value: isZakat,
          onChanged: (value) {
            setState(() {
              isZakat = value ?? false;
              if (isZakat) isSadah = false;
            });
          },
          title: const Text(
            "This donation is Zakat",
            style: TextStyle(fontSize: 14),
          ),
        ),
        CheckboxListTile(
          activeColor: Colors.green,
          value: isSadah,
          onChanged: (value) {
            setState(() {
              isSadah = value ?? false;
              if (isSadah) isZakat = false;
            });
          },
          title: const Text("This donation is Sadqah Jaria",
              style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }

  Widget buildSecureDonation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.lock, color: Colors.grey),
        SizedBox(width: 10),
        Text(
          "Secure Donation",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  Widget buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomButton(
          title: "Donate",
          icon: FontAwesomeIcons.circleDollarToSlot,
          navigateTo: PaymentMethod(
            placeholderText: _controller.text,
            donationtitle: widget.title,
            iszakat: isZakat.toString(),
            issadqah: isSadah.toString(),
            amount: _controller.text,
            quantity: quantity.toString(),
            headingcategory: 'static',
            age: '',
            gender: '',
            selectcategory: widget.selectcategory,
          ),
        ),
        buildAddToCartButton(),
      ],
    );
  }

  Widget buildAddToCartButton() {
    return ElevatedButton.icon(
      onPressed: () {
        if (selectedDonation != null && totalDonationAmount > 0) {
          DonateModel donation = DonateModel(
            id: 'donation_${controller.cartFood.length + 1}',
            title: widget.title,
            des: widget.description,
            image: widget.imageUrl,
            route: '/donation',
            price: totalDonationAmount,
            isZakat: isZakat,
            quantity: quantity,
            age: '',
            gender: '',
            headingcategory: 'static',
            selectcategory: widget.selectcategory,
          );

          controller.addToCart(donation);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Added to cart successfully!")),
          );
        }
      },
      icon: const Icon(FontAwesomeIcons.cartShopping),
      label: const Text("Add to Cart"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      ),
    );
  }
}
