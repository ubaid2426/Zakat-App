import 'package:flutter/material.dart';
// import 'package:zakat_app/Screens/Home/home_main.dart';
import 'package:zakat_app/components/donate.dart';
import 'package:zakat_app/core/app_dummy.dart';
import 'package:zakat_app/model/doantion_model.dart';

class DaigDonation extends StatefulWidget {
  // String prop =LeftToRight(projects: sortedClothes);
  const DaigDonation({super.key});

  @override
  _DaigDonationState createState() => _DaigDonationState();
}

class _DaigDonationState extends State<DaigDonation> {
  String selectedSort = 'Not finished projects first';
  late List<DoantionModel> sortedDaig;

  @override
  void initState() {
    super.initState();
    sortedDaig = List.from(clothes);
    _sortList(selectedSort);
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
        title: const Text("Daig Donation"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedSort = value;
                _sortList(selectedSort);
              });
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'finished projects',
                child: Text('finished projects'),
              ),
              const PopupMenuItem(
                value: 'Not finished projects first',
                child: Text('Not finished projects first'),
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
              // Pass the sorted list to LeftToRight to display it in the home page card
              if (sortedDaig.isNotEmpty)
                // LeftToRight(projects: sortedClothes), // This displays the projects horizontally

              if (sortedDaig.isNotEmpty)
                Column(
                  children: sortedDaig.map((donation) {
                    return Data(
                      imageUrl: donation.imageUrl,
                      title: donation.title,
                      description: donation.description,
                      projectvalue: donation.projectvalue,
                      paidvlaue: donation.paidvlaue,
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

  void _sortList(String sortOption) {
    setState(() {
      switch (sortOption) {
        case 'finished projects':
          sortedDaig = clothes.where((project) {
            return project.paidvlaue >= project.projectvalue;
          }).toList();
          break;

        case 'Not finished projects first':
          sortedDaig = clothes.where((project) {
            return project.paidvlaue < project.projectvalue;
          }).toList();
          break;

        case 'Oldest Items First':
         sortedDaig.sort((a, b) => a.date.compareTo(b.date));
          break;

        case 'Newest Items First':
          sortedDaig.sort((a, b) => b.date.compareTo(a.date));
          break;

        case 'Sort by Remaining Value: Low to High':
          sortedDaig.sort((a, b) => (a.projectvalue - a.paidvlaue)
              .compareTo(b.projectvalue - b.paidvlaue));
          break;

        case 'Sort by Remaining Value: High to Low':
         sortedDaig.sort((a, b) => (b.projectvalue - b.paidvlaue)
              .compareTo(a.projectvalue - a.paidvlaue));
          break;

        default:
          break;
      }
    });
  }
}
