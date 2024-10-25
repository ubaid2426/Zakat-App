import 'package:flutter/material.dart';
import 'package:zakat_app/Screens/donation_service.dart';
import 'package:zakat_app/components/donate.dart';
import 'package:zakat_app/model/doantion_model.dart';
// import 'package:zakat_app/services/donation_service.dart'; // Import the service

class Clothes extends StatefulWidget {
  const Clothes({super.key});

  @override
  _ClothesState createState() => _ClothesState();
}

class _ClothesState extends State<Clothes> {
  String selectedSort = 'Not finished projects first';
  List<DonationModel> sortedClothes = [];

  @override
  void initState() {
    super.initState();
    _fetchSortedClothes();
  }

  Future<void> _fetchSortedClothes() async {
    final donations = await DonationService().fetchDonations(sort: selectedSort, filter: 'unfinished');
    setState(() {
      sortedClothes = donations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF33A248),
                Color(0xFFB2EA50),
              ],
              begin: Alignment.topRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Clothes Donation"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedSort = value;
                _fetchSortedClothes();
              });
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'finished projects',
                child: Text('Finished Projects'),
              ),
              const PopupMenuItem(
                value: 'Not finished projects first',
                child: Text('Not Finished Projects First'),
              ),
              const PopupMenuItem(
                value: 'Oldest Items First',
                child: Text('Oldest Items First'),
              ),
              const PopupMenuItem(
                value: 'Newest Items First',
                child: Text('Newest Items First'),
              ),
              const PopupMenuItem(
                value: 'Sort by Remaining Value: Low to High',
                child: Text('Sort by Remaining Value: Low to High'),
              ),
              const PopupMenuItem(
                value: 'Sort by Remaining Value: High to Low',
                child: Text('Sort by Remaining Value: High to Low'),
              ),
            ],
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (sortedClothes.isNotEmpty)
                Column(
                  children: sortedClothes.map((donation) {
                    print(donation.paidValue);
                    print(donation.projectValue);
                    return Data(
                      imageUrl: donation.imageUrl,
                      title: donation.title,
                      description: donation.description,
                      projectvalue: donation.projectValue,
                      paidvlaue: donation.paidValue,
                       
                    );
                  }).toList(),
                )
              else
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "This domain does not need donations at the moment.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
