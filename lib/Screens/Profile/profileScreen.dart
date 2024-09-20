import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zakat_app/Screens/ContactUs/contact_us.dart';
import 'package:zakat_app/Screens/Profile/Screens/my_detail.dart';
import 'package:zakat_app/Screens/Profile/Screens/my_donation.dart';
import 'package:zakat_app/Screens/Profile/Screens/payment_method.dart';
// import 'package:mainpage/core/App_assest.dart';
// import 'package:zakat_app/core/AppAssests.dart';






class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Profiler(),
          ManyOption1(
              menuTitle: "My Detail",
              fontawesome: FontAwesomeIcons.addressCard,
              navigateTo: MyDetail()),
          SizedBox(
            height: 10,
          ),
          ManyOption1(
              menuTitle: "Payment Method",
              fontawesome: FontAwesomeIcons.creditCard,
              navigateTo: PaymentMethod()),
          SizedBox(
            height: 10,
          ),
          ManyOption1(
              menuTitle: "My Donation",
              fontawesome: FontAwesomeIcons.fileWaveform,
              navigateTo: MyDonation()),
          SizedBox(
            height: 10,
          ),
          ManyOption1(
              menuTitle: "Contact Us",
              fontawesome: FontAwesomeIcons.addressBook,
              navigateTo: ContactUs()),
          SizedBox(
            height: 10,
          ),
          ManyOption1(
              menuTitle: "LogOut",
              fontawesome: FontAwesomeIcons.powerOff,
              navigateTo: LogOut()),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Profiler extends StatelessWidget {
  const Profiler({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      child: Column(
        children: [
          // padding: const EdgeInsets.only(top: 100),
          Container(
            height: 420,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF33A248), // First color (#33A248)
                  Color(0xFFB2EA50), // Second color (#B2EA50)
                ],
                begin: Alignment.bottomRight, // Start at bottom-right
                end: Alignment.topLeft, // End at top-left
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Text(
                  "Profile",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                 const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Column(
                    children: [
                      const Text(
                        "THE ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        " NEW ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        " DONOR",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: const Text(
                          "Ubaid Ur Rehman",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 253, 251, 251),
                        ),
                        width: MediaQuery.of(context).size.width * 0.70,
                        height: 100,
                        child: const Padding(
                          padding: EdgeInsets.all(19.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Donations",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 103, 102, 102),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "0",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 8, 8, 8),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              VerticalDivider(),
                              Column(
                                children: [
                                  Text(
                                    "Amount",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 103, 102, 102),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Rs. 0.00",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 8, 8, 8),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ManyOption1 extends StatelessWidget {
  final String menuTitle;
  final IconData fontawesome;
  final Widget navigateTo;
  const ManyOption1({
    super.key,
    required this.menuTitle,
    required this.fontawesome,
    required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedColor: const Color(0xFF7fc23a),
      leading: Icon(
        fontawesome,
        size: 23,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      title: Text(
        menuTitle,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 20,
            ),
      ),
      onTap: () {
        // Handle the tap event here
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => navigateTo), // Navigate to the screen
        );
      },
    );
  }
}







void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfileScreen(),
  ));
}