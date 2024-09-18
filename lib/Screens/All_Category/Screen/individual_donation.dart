import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';

class IndividualDonation extends StatefulWidget {
  @override
  _IndividualDonationState createState() => _IndividualDonationState();
}

class _IndividualDonationState extends State<IndividualDonation> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  // final TextEditingController _streetAddressController =
  //     TextEditingController();
  // final TextEditingController _apartmentController = TextEditingController();
  // final TextEditingController _cityController = TextEditingController();
  // final TextEditingController _stateController = TextEditingController();

  // String? _items;
  String? _selectedCountry;
  String? selectedValue;
  // List of categories and countries
  final List<String> items = [
    'Poertable House',
    'Masjid Maintenance',
    'Marriage Support',
    'Flood Relief',
    'Widow Family Support',
    'Small Business Setup',
    'Clothes',
    'Medical Bed',
    'Wheel Chair',
    'Tree Donation',
    'Daig Donation',
    'Meal Donation',
    'Orphan Donation',
    'Water Cooler',
    'Masjid Construction',
    'Quran Donation',
    'Other',
  ];
  final List<String> _countries = [
    'Australia',
    'United States',
    'United Kingdom',
    'India',
    'Pakistan'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:  Color(0xFF29C77B),
      appBar: AppBar(
            backgroundColor: Color(0xFF29C77B),
        title: const Text('Request For Donations' ,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ExpandableText(
                      'You can request the Sadqazakaat team to donate Sadqa Jariya on behalf of your beloved ones by choosing from the categories below. Fill out the form with your details, and we will verify and process your request. Your donation will create lasting blessings and support for those in need, honoring your loved ones meaningfully. Our categories include food, clothing, medical assistance, educational support, housing, and more. Your contribution can make a significant impact, bringing comfort and relief to those in need while earning continuous rewards for your loved ones. Thank you for your generosity and dedication to making a difference.',
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 18, 18, 18)),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Fill The Form",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name *',
                        hintText: 'E.g. Ali',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone *',
                        hintText: 'E.g. +1 300 400 5000',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Category',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: items
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: 160,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: Color(0xFF29C77B),
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xFF29C77B),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Message *',
                        hintText: 'E.g. You can add a new line',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a message';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Country *'),
                      value: _selectedCountry,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCountry = newValue;
                        });
                      },
                      items: _countries
                          .map<DropdownMenuItem<String>>((String country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a country';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar or process the data
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Submitting form')),
                            );
                          }
                        },
                        child: const Text('SUBMIT'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: IndividualDonation(),
  ));
}
