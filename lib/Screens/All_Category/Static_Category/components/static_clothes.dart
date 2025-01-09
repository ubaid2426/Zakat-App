import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sadqahzakat/Screens/PaymentMethod/payment_method.dart';
import 'package:sadqahzakat/components/CounterButton/counter_button.dart';
import 'package:sadqahzakat/components/custom_button.dart';
import 'package:sadqahzakat/controller/controller.dart';
import 'package:sadqahzakat/model/donate_model.dart';

class StaticClothesDesign extends StatefulWidget {
  final String imageUrl;
  final String description;
  final String selectcategory;
  final List<Map<String, dynamic>>? donationOptions;

  const StaticClothesDesign({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.donationOptions,
    required this.selectcategory,
  });

  @override
  State<StaticClothesDesign> createState() => _StaticClothesDesignState();
}

class _StaticClothesDesignState extends State<StaticClothesDesign> {
  final FoodController controller = Get.put(FoodController());
  final TextEditingController _controller = TextEditingController();

  bool isSelected = false;
  bool isZakat = false;
  bool isSadah = false;
  bool isMale = false;
  bool isFemale = false;
  String? ageTitle;
  String? selectedGender;
  int quantity = 1;
  int totalDonationAmount = 0;
  Map<String, dynamic>? selectedDonation;

  @override
  void initState() {
    super.initState();
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
    return Padding(
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
            _buildDescriptionText(),
            _buildImageSection(),
            _buildGenderSelection(),
            _buildDonationDropdown(),
            _buildDonationSection(),
            _buildSadqahBox(),
            _buildZakatBox(),
            _buildSecureDonation(),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpandableText(
        widget.description,
        trimType: TrimType.lines,
        trim: 2,
        style: const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 88, 88, 88),
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.none,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(widget.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCheckbox(
          label: "Male",
          value: isMale,
          onChanged: (value) {
            setState(() {
              isMale = value;
              isFemale = !value;
              selectedGender = isMale ? "Male" : null;
            });
          },
        ),
        _buildCheckbox(
          label: "Female",
          value: isFemale,
          onChanged: (value) {
            setState(() {
              isFemale = value;
              isMale = !value;
              selectedGender = isFemale ? "Female" : null;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSadqahBox() {
    return _buildCheckbox(
      label: "This donation is Sadqah",
      value: isSadah,
      onChanged: (value) {
        setState(() {
          isSadah = value;
          isZakat = !value;
        });
      },
    );
  }

  Widget _buildZakatBox() {
    return _buildCheckbox(
      label: "This donation is Zakat",
      value: isZakat,
      onChanged: (value) {
        setState(() {
          isZakat = value;
          isSadah = !value;
        });
      },
    );
  }

  Widget _buildCheckbox({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Checkbox(
          value: value,
          activeColor: const Color(0xFF7fc23a),
          onChanged: (newValue) => onChanged(newValue ?? false),
        ),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField<Map<String, dynamic>>(
                          decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF7fc23a),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                        // isExpanded: true,
                        hint: const Text(
                          'Choose a donation option',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        value: selectedDonation,
                        items: widget.donationOptions!
                            .map((option) => DropdownMenuItem<Map<String, dynamic>>(
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
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedDonation = newValue;
                            ageTitle = selectedDonation?['title'];
                            updateTotalAmount();
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        dropdownColor: const Color(0xFF7fc23a),
                      ),
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


  Widget _buildDonationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Text(
            "Enter Donation Amount (\$)",
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
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
            label: Text(quantity.toString(),
                style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: _controller,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: "Total Donation Amount (Rs)",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                title: "Donate",
                icon: FontAwesomeIcons.circleDollarToSlot,
                navigateTo: PaymentMethod(
                  placeholderText: _controller.text,
                  donationtitle: "staticclothes",
                  iszakat: isZakat.toString(),
                  issadqah: isSadah.toString(),
                  amount: _controller.text,
                  quantity: quantity.toString(),
                  headingcategory: 'static',
                  age: ageTitle,
                  gender: selectedGender,
                  selectcategory: widget.selectcategory,
                ),
              ),
              _buildAddToCartButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return Material(
      child: InkWell(
        onTap: () {
          print("press it");
          if (selectedDonation != null && totalDonationAmount > 0) {
            setState(() {
              isSelected = !isSelected;
            });

            DonateModel donation = DonateModel(
              id: 'donation_${controller.cartFood.length + 1}',
              title: "staticclothes",
              des: widget.description,
              image: widget.imageUrl,
              route: '/donation',
              price: totalDonationAmount,
              isZakat: isZakat,
              quantity: quantity,
              age: ageTitle,
              gender: selectedGender,
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

  Widget _buildSecureDonation() {
    return Container(
      height: 70,
      color: const Color(0xFFF1F1F1),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock, color: Color.fromARGB(72, 81, 75, 75)),
          SizedBox(width: 10),
          Text(
            'Secure Donation',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
