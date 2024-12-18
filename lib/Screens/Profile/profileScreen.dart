import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sadqahzakat/Screens/ContactUs/contact_us.dart';
import 'package:sadqahzakat/Screens/Login/Screen/login_page.dart';
import 'package:sadqahzakat/Screens/PaymentMethod/payment_method.dart';
import 'package:sadqahzakat/Screens/Profile/Screens/my_detail.dart';
import 'package:sadqahzakat/Screens/Profile/Screens/my_donation.dart';
import 'package:sadqahzakat/Screens/Profile/Screens/setting.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  // Secure storage instance
  Future<void> _logout(BuildContext context) async {
    // Clear the stored access token
    await storage.delete(key: 'access_token');

    // Navigate back to login or welcome screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
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
  void initState() {
    super.initState();
    fetchDonationHistory();
  }

  double totalAmount = 0.0;
  int totalDonations = 0;
  int zakatCount = 0;
  int sadqahCount = 0;
  String? donorName; // To store the name from secure storage
  String? donorId;
  bool isLoading = true; // To show loading state
  // Fetch data from the provided endpoint

  Future<void> fetchDonationHistory() async {
          donorName = await storage.read(key: 'user_name');
      donorId = await storage.read(key: 'user_id');
    if (donorId == null || donorName == null) {
      // You can show an error message or use default values if they are null
      print("Donor ID or Name is null");
      return;
    }
    try {
      final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/data/donation-history/$donorId/$donorName/'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        setState(() {
          totalAmount = data['total_amount']?.toDouble() ?? 0.0;
          totalDonations = data['total_donations'] ?? 0;
          zakatCount = data['zakat_count'] ?? 0;
          sadqahCount = data['sadqah_count'] ?? 0;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Profiler(
                totalAmount: totalAmount,
                totalDonations: totalDonations,
                zakatCount: zakatCount,
                sadqahCount: sadqahCount),
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
                navigateTo: PaymentMethod(
                  placeholderText: null,
                  donationtitle: '',
                  iszakat: null,
                  issadqah: null,
                  amount: '',
                  quantity: '',
                )),
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

// Secure storage initialization
final FlutterSecureStorage storage = const FlutterSecureStorage();

class Profiler extends StatefulWidget {
  final double totalAmount;
  final int totalDonations;
  final int zakatCount;
  final int sadqahCount;
  const Profiler({
    super.key,
    required this.totalAmount,
    required this.totalDonations,
    required this.zakatCount,
    required this.sadqahCount,
  });

  @override
  State<Profiler> createState() => _ProfilerState();
}

class _ProfilerState extends State<Profiler> {
  String? donorName; // To store the name from secure storage
  String? donorId; // To store the ID from secure storage
  bool isLoading = true; // To track loading state

  @override
  void initState() {
    super.initState();
    initializeStorage();
  }

  // Async initialization of secure storage data
  Future<void> initializeStorage() async {
    try {
      // Perform initialization or secure password settings if necessary
      String? name = await storage.read(key: 'user_name');
      String? id = await storage.read(key: 'user_id');

      setState(() {
        donorName = name ?? 'Unknown';
        donorId = id ?? 'Unknown';
        isLoading = false; // Indicate loading is complete
      });
    } catch (e) {
      showMessage('Error: $e');
      setState(() {
        isLoading = false; // Handle error gracefully
      });
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 520,
        child: isLoading
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loading spinner while data is loading
            : Column(
                children: [
                  Container(
                    height: 520,
                    // height: double.infinity,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF33A248),
                          Color(0xFFB2EA50),
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
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
                          height: 400,
                          child: Column(
                            children: [
                              const Text(
                                "THE ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                " NEW ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                " DONOR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Text(
                                  donorName ?? 'Loading...',
                                  style: const TextStyle(
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
                                  color:
                                      const Color.fromARGB(255, 253, 251, 251),
                                ),
                                width: MediaQuery.of(context).size.width * 0.70,
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(19.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Donations",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 103, 102, 102),
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "${widget.totalDonations}",
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 8, 8, 8),
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height:
                                                60, // Set an arbitrary height
                                            child: VerticalDivider(
                                              width: 10,
                                              // color: Colors.black,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                "Total Amount",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 103, 102, 102),
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "${widget.totalAmount}",
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 8, 8, 8),
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Total Zakat",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 103, 102, 102),
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "${widget.zakatCount}",
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 8, 8, 8),
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height:
                                                60, // Set an arbitrary height
                                            child: VerticalDivider(
                                              width: 10,
                                              // color: Colors.black,
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                "Total Sadqah ",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 103, 102, 102),
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                "${widget.sadqahCount}",
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 8, 8, 8),
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ],
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
        size: 20,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      title: Text(
        menuTitle,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
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
















// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:zakat_app/Screens/ContactUs/contact_us.dart';
// import 'package:zakat_app/Screens/Login/Screen/login_page.dart';
// import 'package:zakat_app/Screens/PaymentMethod/payment_method.dart';
// import 'package:zakat_app/Screens/Profile/Screens/my_detail.dart';
// import 'package:zakat_app/Screens/Profile/Screens/my_donation.dart';
// import 'package:zakat_app/Screens/Profile/Screens/setting.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final FlutterSecureStorage storage = const FlutterSecureStorage();

//   double totalAmount = 0.0;
//   int totalDonations = 0;
//   int zakatCount = 0;
//   int sadqahCount = 0;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchDonationHistory();
//   }

//   Future<void> fetchDonationHistory() async {
//     setState(() => isLoading = true);
//     try {
//       final response = await http.get(
//         Uri.parse('http://127.0.0.1:8000/data/donation-history/3/Ubaid ur/'),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           totalAmount = (data['total_amount'] ?? 0).toDouble();
//           totalDonations = data['total_donations'] ?? 0;
//           zakatCount = data['zakat_count'] ?? 0;
//           sadqahCount = data['sadqah_count'] ?? 0;
//           isLoading = false;
//         });
//       } else {
//         _showSnackbar('Failed to load donation history');
//       }
//     } catch (e) {
//       _showSnackbar('Error loading data: $e');
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   Future<void> _logout() async {
//     await storage.delete(key: 'access_token');
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const LoginPage()),
//     );
//   }

//   void _showLogoutConfirmation() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text('Log Out'),
//         content: const Text('Are you sure you want to log out?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               _logout();
//             },
//             child: const Text('Log Out'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Profiler(
//                     totalAmount: totalAmount,
//                     totalDonations: totalDonations,
//                     zakatCount: zakatCount,
//                     sadqahCount: sadqahCount,
//                   ),
//                   _buildMenuOptions(),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _buildMenuOptions() {
//     return Column(
//       children: [
//         _menuOption(
//           title: "My Detail",
//           icon: FontAwesomeIcons.addressCard,
//           destination: const MyDetail(),
//         ),
//         _menuOption(
//           title: "Payment Method",
//           icon: FontAwesomeIcons.creditCard,
//           destination: PaymentMethod(
//             placeholderText: null,
//             donationtitle: '',
//             iszakat: null,
//             issadqah: null,
//           ),
//         ),
//         _menuOption(
//           title: "My Donation",
//           icon: FontAwesomeIcons.fileWaveform,
//           destination: const MyDonation(),
//         ),
//         _menuOption(
//           title: "Contact Us",
//           icon: FontAwesomeIcons.addressBook,
//           destination: const ContactUs(),
//         ),
//         _menuOption(
//           title: "Setting",
//           icon: FontAwesomeIcons.gear,
//           destination: const SettingsScreen(),
//         ),
//         _menuOption(
//           title: "LogOut",
//           icon: FontAwesomeIcons.powerOff,
//           action: _showLogoutConfirmation,
//         ),
//       ],
//     );
//   }

//   Widget _menuOption({
//     required String title,
//     required IconData icon,
//     Widget? destination,
//     VoidCallback? action,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: Theme.of(context).colorScheme.onSurface),
//       title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
//       onTap: () {
//         if (action != null) {
//           action();
//         } else if (destination != null) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => destination),
//           );
//         }
//       },
//     );
//   }
// }

// class Profiler extends StatefulWidget {
//   final double totalAmount;
//   final int totalDonations;
//   final int zakatCount;
//   final int sadqahCount;

//   const Profiler({
//     super.key,
//     required this.totalAmount,
//     required this.totalDonations,
//     required this.zakatCount,
//     required this.sadqahCount,
//   });

//   @override
//   State<Profiler> createState() => _ProfilerState();
// }

// class _ProfilerState extends State<Profiler> {
//   final FlutterSecureStorage storage = const FlutterSecureStorage();
//   String? donorName;
//   String? donorId;

//   @override
//   void initState() {
//     super.initState();
//     _fetchDonorDetails();
//   }

//   Future<void> _fetchDonorDetails() async {
//     try {
//       donorName = await storage.read(key: 'user_name') ?? 'Unknown';
//       donorId = await storage.read(key: 'user_id') ?? 'Unknown';
//       setState(() {});
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching donor details: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF33A248), Color(0xFFB2EA50)],
//           begin: Alignment.bottomRight,
//           end: Alignment.topLeft,
//         ),
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(20),
//           bottomRight: Radius.circular(20),
//         ),
//       ),
//       child: Column(
//         children: [
//           const Text(
//             "Profile",
//             style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             donorName ?? 'Loading...',
//             style: const TextStyle(fontSize: 20),
//           ),
//           const SizedBox(height: 20),
//           _donationStats(),
//         ],
//       ),
//     );
//   }

//   Widget _donationStats() {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             _statRow("Total Donations", "${widget.totalDonations}"),
//             _statRow("Total Amount", "\$${widget.totalAmount.toStringAsFixed(2)}"),
//             _statRow("Zakat Count", "${widget.zakatCount}"),
//             _statRow("Sadqah Count", "${widget.sadqahCount}"),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _statRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: const TextStyle(fontSize: 16)),
//           Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }
