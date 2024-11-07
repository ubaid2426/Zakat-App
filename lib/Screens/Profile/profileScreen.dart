import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zakat_app/Screens/ContactUs/contact_us.dart';
import 'package:zakat_app/Screens/Login/Screen/login_page.dart';
import 'package:zakat_app/Screens/PaymentMethod/payment_method.dart';
import 'package:zakat_app/Screens/Profile/Screens/my_detail.dart';
import 'package:zakat_app/Screens/Profile/Screens/my_donation.dart';
import 'package:zakat_app/Screens/Profile/Screens/setting.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  final FlutterSecureStorage storage =
      const FlutterSecureStorage(); // Secure storage instance

  Future<void> _logout(BuildContext context) async {
    // Clear the stored access token
    await storage.delete(key: 'access_token');

    // Navigate back to login or welcome screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>const LoginPage()),
    ); // Replace with your login route
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Log Out'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _logout(
                    context); // Navigate to logout page or perform logout action
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Profiler(),
            const ManyOption1(
                menuTitle: "My Detail",
                fontawesome: FontAwesomeIcons.addressCard,
                navigateTo: MyDetail()),
            const SizedBox(
              height: 10,
            ),
            const ManyOption1(
                menuTitle: "Payment Method",
                fontawesome: FontAwesomeIcons.creditCard,
                navigateTo: PaymentMethod(placeholderText: null,)),
            const SizedBox(
              height: 10,
            ),
            const ManyOption1(
                menuTitle: "My Donation",
                fontawesome: FontAwesomeIcons.fileWaveform,
                navigateTo: MyDonation()),
            const SizedBox(
              height: 10,
            ),
            const ManyOption1(
                menuTitle: "Contact Us",
                fontawesome: FontAwesomeIcons.addressBook,
                navigateTo: ContactUs()),
            const SizedBox(
              height: 10,
            ),
            const ManyOption1(
                menuTitle: "Setting",
                fontawesome: FontAwesomeIcons.gear,
                navigateTo: SettingsScreen()),
            const SizedBox(
              height: 10,
            ),
            ManyOption1(
              menuTitle: "LogOut",
              fontawesome: FontAwesomeIcons.powerOff,
              onPressed: () {
                showLogoutConfirmationDialog(
                    context); // Show confirmation dialog
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class Profiler extends StatelessWidget {
  const Profiler({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
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
                  const Text(
                    "Profile",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
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
                                          color: Color.fromARGB(
                                              255, 103, 102, 102),
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
                                          color: Color.fromARGB(
                                              255, 103, 102, 102),
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
      ),
    );
  }
}

class ManyOption1 extends StatelessWidget {
  final String menuTitle;
  final IconData fontawesome;
  final Widget? navigateTo; // Optional for custom actions like showing dialogs
  final VoidCallback? onPressed; // Added onPressed to trigger actions

  const ManyOption1({
    super.key,
    required this.menuTitle,
    required this.fontawesome,
    this.navigateTo,
    this.onPressed, // Optional parameter for custom actions
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
        if (onPressed != null) {
          onPressed!(); // Trigger custom action if provided
        } else if (navigateTo != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigateTo!),
          );
        }
      },
    );
  }
}

class LogOut extends StatelessWidget {
  const LogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LogOut Page")),
      body: const Center(child: Text("You have been logged out.")),
    );
  }
}
