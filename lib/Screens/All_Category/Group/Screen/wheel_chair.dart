import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/Home/home_main.dart';
import 'package:sadqahzakat/Screens/donation_service.dart';
import 'package:sadqahzakat/components/donate.dart';
// import 'package:sadqahzakat/components/navigation.dart';
import 'package:sadqahzakat/model/doantion_model.dart';

void main() {
  runApp(const WheelChair());
}

class WheelChair extends StatelessWidget {
  const WheelChair({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Queue Card System',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CardQueueScreen(),
    );
  }
}

class CardQueueScreen extends StatefulWidget {
  const CardQueueScreen({super.key});

  @override
  _CardQueueScreenState createState() => _CardQueueScreenState();
}

class _CardQueueScreenState extends State<CardQueueScreen> {
  String selectedSort = 'Not Finished Projects First';
  List<DonationModel> sortedClothes = [];
  bool isLoading = true;
  String? currentProjectId; // Tracks the project ID currently being donated to

  final List<String> sortOptions = [
    'Finished Projects',
    'Not Finished Projects First',
    // 'Oldest Items First',
    // 'Newest Items First',
    // 'Sort by Remaining Value: Low to High',
    // 'Sort by Remaining Value: High to Low',
  ];

  @override
  void initState() {
    super.initState();
    _fetchSortedClothes();
  }

  Future<void> _fetchSortedClothes() async {
    String filterValue = 'unfinished'; // Default filter
    switch (selectedSort) {
      case 'Finished Projects':
        filterValue = 'finished';
        break;
      case 'Not Finished Projects First':
        filterValue = 'unfinished';
        break;
    }

    String sortValue = 'oldest';
    // switch (selectedSort) {
    //   case 'Oldest Items First':
    //     sortValue = 'oldest';
    //     break;
    //   case 'Newest Items First':
    //     sortValue = 'newest';
    //     break;
    //   case 'Sort by Remaining Value: Low to High':
    //     sortValue = 'remaining_low_to_high';
    //     break;
    //   case 'Sort by Remaining Value: High to Low':
    //     sortValue = 'remaining_high_to_low';
    //     break;
    // }

    setState(() {
      isLoading = true;
    });

    try {
      final donations = await DonationService().fetchDonations(
        sort: sortValue,
        filter: filterValue,
        category: "wheelchair",
        selectCategory: "group",
      );

      setState(() {
        sortedClothes = donations;
      });
    } catch (e) {
      print("Error fetching donations: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // void donateToProject(String projectId) {
  //   setState(() {
  //     currentProjectId = projectId;
  //   });
  // }
  void donateToProject(DonationModel donation) {
    final currentProject = sortedClothes.firstWhere(
      (project) => project.id == currentProjectId,
      orElse: () => donation,
    );

    final currentProgress =
        currentProject.paidValue! / currentProject.projectValue!;

    if (currentProgress < 1.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please complete the current project "${currentProject.title}" before donating to another.',
          ),
        ),
      );
      return;
    }

    setState(() {
      currentProjectId = donation.id;
    });
  }

  void navigateToDetails(DonationModel donation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Data(
          imageUrl: donation.imageUrl,
          title: donation.title,
          description: donation.description,
          projectvalue: donation.projectValue,
          paidvlaue: donation.paidValue,
          selectcategory: 'wheelchair',
          screentitle: 'Wheel Chair Donation',
          address: donation.addres,
              latitude: donation.latitude!,
          longitude: donation.longitude!,
        ),
      ),
    );
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Wheel Chair"),
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Dropdown at the top of the list
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sort by: ",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: selectedSort,
                    isExpanded: false,
                    dropdownColor: Colors.white,
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.black),
                    items: sortOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child:
                            Text(option, style: const TextStyle(fontSize: 14)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedSort = newValue;
                          _fetchSortedClothes();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          // Card list
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: sortedClothes.length,
                    itemBuilder: (context, index) {
                      final donation = sortedClothes[index];
                      final isLocked = index > 0 &&
                          sortedClothes[index - 0].id != currentProjectId;

                      final progress = donation.paidValue! /
                          donation.projectValue!; // Calculate progress

                      return GestureDetector(
                        onTap: () {
                          if (!isLocked) {
                            donateToProject(donation);
                            navigateToDetails(donation);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'This project is locked. Complete the current one to unlock it.'),
                              ),
                            );
                          }
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Card Image
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    child: Image.network(
                                      "https://sadqahzakaat.com${donation.imageUrl}",
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Title
                                        Text(
                                          donation.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Linear Progress Indicator
                                        LinearProgressIndicator(
                                          value: progress,
                                          backgroundColor: Colors.grey[300],
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(
                                            Color(0xFF7fc23a),
                                          ),
                                          minHeight: 10,
                                        ),
                                        const SizedBox(height: 8),
                                        // Progress Text
                                        Text(
                                          'Progress: ${(progress * 100).toInt()}%',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (isLocked)
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.5),
                                    child: const Center(
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 48,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
