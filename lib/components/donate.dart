import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zakat_app/Screens/Profile/Screens/payment_method.dart';
import 'package:zakat_app/components/custom_button.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:zakat_app/controller/controller.dart';
import 'package:zakat_app/model/donate_model.dart';

class Data extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;

  const Data({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  final TextEditingController _controller = TextEditingController(text: "32");
  bool isSelected = false;
  final double projectValue = 10000; // Example project value
  final double paidValue = 1000; // Example paid value

  //   void initState() {
  //   super.initState();
  //  String donationAmount = _controller.text;
  // }

  final FoodController controller = Get.put(FoodController());

  @override
  Widget build(BuildContext context) {
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
                  fontSize: 32,
                  decoration: TextDecoration.none,
                  fontFamily: "Roboto",
                  color: Color(0xFF29C77B),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const Divider(
                color: Color(0xFF29C77B),
                thickness: 4,
                indent: 50,
                endIndent: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 88, 88, 88),
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              buildProjectDetails(context),
              const SizedBox(height: 40),
              buildProgressIndicator(),
              const SizedBox(height: 20),
              buildDonationSection(),
              const SizedBox(height: 20),
              buildSecureDonation(),
            ],
          ),
        ),
      ),
    );
  }

  // Build the details row containing project value, paid, remaining
  Widget buildProjectDetails(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 237, 228, 228),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildProjectInfo('Rs ${projectValue.toInt()}', 'Project value'),
          buildProjectInfo('${paidValue.toInt()}', 'Paid'),
          buildProjectInfo(
              'Rs ${(projectValue - paidValue).toInt()}', 'Remaining'),
        ],
      ),
    );
  }

  // Build the progress indicator
  Widget buildProgressIndicator() {
    double progress = paidValue / projectValue;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF29C77B)),
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
            color: Color(0xFF29C77B),
          ),
        ),
      ],
    );
  }

  // Reusable widget for displaying project info
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

  // Build the donation input section with amount input and buttons
  Widget buildDonationSection() {
    double progress = paidValue / projectValue;

    // If donation is 100% or more, show "Donation Completed" button
    if (progress >= 1.0) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: null, // Disabled button as donation is completed
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 15.0,
            ),
            backgroundColor: Colors.green,
          ),
          child: const Text(
            "DONATION COMPLETED",
            style: TextStyle(
                fontSize: 18.0,
                decoration: TextDecoration.none,
                color: Colors.white),
          ),
        ),
      );
    }
    // bool isSelected = false;
    // Otherwise, show the "Donate" and "Checkout" buttons
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Enter Donation Amount (\$)",
            style: TextStyle(
                fontSize: 18.0,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          Material(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 36.0),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                  title: "Donate",
                  icon: FontAwesomeIcons.circleDollarToSlot,
                  navigateTo: PaymentMethod()),
              // ElevatedButton(
              //   onPressed: () {
              //     print("Donate clicked with amount: ${_controller.text}");
              //   },
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 30.0,
              //       vertical: 15.0,
              //     ),
              //     backgroundColor: Colors.green,
              //   ),
              //   child: const Text("DONATE", style: TextStyle(fontSize: 18.0)),
              // ),
              InkWell(
                onHover: (Value) {
                  setState(() {
                    isSelected = Value;
                  });
                },
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                  double donationAmount = double.parse(_controller.text);

                  // Create a DonateModel object with all required fields
                  DonateModel donation = DonateModel(
                    id: 'donation_${controller.cartFood.length + 1}', // Unique ID
                    title: widget.title, // Pass the title from the widget
                    des: widget
                        .description, // Pass the description from the widget
                    image:
                        widget.imageUrl, // Pass the image URL from the widget
                    route:
                        '/donation', // Example route, update this to your actual route
                    price:
                        donationAmount, // Donation amount entered by the user
                  );

                  // Add donation to the cart in the controller
                  controller.addToCart(donation);
                },
                splashColor: Color(0xFF7fc23a),
                child: Container(
                  width: 150,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isSelected ? Color(0xFF7fc23a) : Colors.white,
                    border: Border.all(color: Color(0xFF7fc23a)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Add To Cart",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.cartShopping,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ],
                  ),
                ),
              )
              // ElevatedButton(
              //   onPressed: () {
              //     double donationAmount = double.parse(_controller.text);

              //     // Create a DonateModel object with all required fields
              //     DonateModel donation = DonateModel(
              //       id: 'donation_${controller.cartFood.length + 1}', // Unique ID
              //       title: widget.title, // Pass the title from the widget
              //       des: widget
              //           .description, // Pass the description from the widget
              //       image:
              //           widget.imageUrl, // Pass the image URL from the widget
              //       route:
              //           '/donation', // Example route, update this to your actual route
              //       price:
              //           donationAmount, // Donation amount entered by the user
              //     );

              //     // Add donation to the cart in the controller
              //     controller.addToCart(donation);
              //   },
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 30.0,
              //       vertical: 15.0,
              //     ),
              //     backgroundColor: Colors.green,
              //   ),
              //   child: const Text("CHECKOUT",
              //       style: TextStyle(
              //           fontSize: 18.0, decoration: TextDecoration.none)),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  // Build the secure donation section at the bottom
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
}














// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:zakat_app/controller/controller.dart';

// class Data extends StatefulWidget {
//   final String imageUrl;
//   final String title;
//   final String description;

//   const Data({
//     super.key,
//     required this.imageUrl,
//     required this.title,
//     required this.description,
//   });

//   @override
//   State<Data> createState() => _DataState();
// }

// class _DataState extends State<Data> {
//   final TextEditingController _controller = TextEditingController(text: "32");
//   bool isSelected = false;
//   final double projectValue = 10000; // Example project value
//   final double paidValue = 1000; // Example paid value

//   final FoodController controller = Get.put(FoodController());

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(19, 19, 19, 0),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Column(
//               children: [
//                 const SizedBox(height: 30),
//                 Text(
//                   widget.title,
//                   style: const TextStyle(
//                     fontSize: 32,
//                     decoration: TextDecoration.none,
//                     fontFamily: "Roboto",
//                     color: Color(0xFF29C77B),
//                     fontWeight: FontWeight.w700,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const Divider(
//                   color: Color(0xFF29C77B),
//                   thickness: 4,
//                   indent: 50,
//                   endIndent: 50,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     widget.description,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       color: Color.fromARGB(255, 88, 88, 88),
//                       fontFamily: "Montserrat",
//                       fontWeight: FontWeight.w600,
//                       decoration: TextDecoration.none,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   height: 250,
//                   width: MediaQuery.of(context).size.width,
//                   child: Image.asset(
//                     widget.imageUrl,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 buildProjectDetails(context),
//                 const SizedBox(height: 40),
//                 buildProgressIndicator(),
//                 const SizedBox(height: 20),
//                 buildDonationSection(),
//                 const SizedBox(height: 20),
//                 buildSecureDonation(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildProjectDetails(BuildContext context) {
//     return Container(
//       height: 100,
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: const Color.fromARGB(255, 237, 228, 228),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           buildProjectInfo('Rs ${projectValue.toInt()}', 'Project value'),
//           buildProjectInfo('${paidValue.toInt()}', 'Paid'),
//           buildProjectInfo('Rs ${(projectValue - paidValue).toInt()}', 'Remaining'),
//         ],
//       ),
//     );
//   }

//   Widget buildProgressIndicator() {
//     double progress = paidValue / projectValue;
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: LinearProgressIndicator(
//             value: progress,
//             backgroundColor: Colors.grey[300],
//             valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF29C77B)),
//             minHeight: 10,
//           ),
//         ),
//         const SizedBox(height: 10),
//         Text(
//           '${(progress * 100).toInt()}%',
//           style: const TextStyle(
//             fontSize: 16,
//             decoration: TextDecoration.none,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF29C77B),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildProjectInfo(String value, String label) {
//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: const Color.fromARGB(255, 237, 228, 228),
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 decoration: TextDecoration.none,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Color.fromARGB(255, 128, 126, 126),
//                 fontFamily: "Montserrat",
//                 decoration: TextDecoration.none,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDonationSection() {
//     double progress = paidValue / projectValue;

//     if (progress >= 1.0) {
//       return Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: ElevatedButton(
//           onPressed: null,
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 30.0,
//               vertical: 15.0,
//             ),
//             backgroundColor: Colors.green,
//           ),
//           child: const Text(
//             "DONATION COMPLETED",
//             style: TextStyle(fontSize: 18.0, decoration: TextDecoration.none, color: Colors.white),
//           ),
//         ),
//       );
//     }

//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             "Enter Donation Amount (\$)",
//             style: TextStyle(fontSize: 18.0, decoration: TextDecoration.none, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20.0),
//           TextField(
//             controller: _controller,
//             keyboardType: TextInputType.number,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 36.0),
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
//             ),
//           ),
//           const SizedBox(height: 30.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   print("Donate clicked with amount: ${_controller.text}");
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 30.0,
//                     vertical: 15.0,
//                   ),
//                   backgroundColor: Colors.green,
//                 ),
//                 child: const Text("DONATE", style: TextStyle(fontSize: 18.0)),
//               ),
//               InkWell(
//                 onTap: () {
//                   setState(() {
//                     isSelected = !isSelected;
//                   });
//                 },
//                 splashColor: Color(0xFF7fc23a),
//                 child: Container(
//                   width: 150,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: isSelected ? Colors.black : Colors.white,
//                     border: Border.all(color: Color(0xFF7fc23a)),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                         "Add To Cart",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w400,
//                           decoration: TextDecoration.none,
//                           color: isSelected ? Colors.white : Colors.black,
//                         ),
//                       ),
//                       Icon(
//                         FontAwesomeIcons.cartPlus,
//                         color: isSelected ? Colors.white : Colors.black,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildSecureDonation() {
//     return Container(
//       height: 70,
//       color: const Color(0xFFF1F1F1),
//       child: const Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.lock, color: Color.fromARGB(72, 81, 75, 75)),
//           SizedBox(width: 10),
//           Text(
//             ' Secure Donation',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
//           ),
//         ],
//       ),
//     );
//   }
// }
