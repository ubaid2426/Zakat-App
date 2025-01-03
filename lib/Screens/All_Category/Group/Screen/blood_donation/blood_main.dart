import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/All_Category/Group/Screen/blood_donation/blood_donation_card.dart';
// import 'package:sadqahzakat/Screens/All_Category/Group/all_category.dart';
import 'package:sadqahzakat/Screens/Home/home_main.dart';
import 'package:sadqahzakat/Screens/donation_service.dart';
// import 'package:sadqahzakat/components/donate.dart';
// import 'package:sadqahzakat/components/navigation.dart';
import 'package:sadqahzakat/model/doantion_model.dart';

void main() {
  runApp(const BloodMain());
}

class BloodMain extends StatelessWidget {
  const BloodMain({super.key});

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

  @override
  void initState() {
    super.initState();
    _fetchSortedClothes();
  }

  Future<void> _fetchSortedClothes() async {
    setState(() {
      isLoading = true;
    });

    try {
      final donations = await DonationService().fetchDonations(
        sort: 'oldest',
        filter: 'unfinished',
        category: "blood",
        selectCategory: "group",
      );

      setState(() {
        sortedClothes = donations;
        if (sortedClothes.isNotEmpty) {
          currentProjectId =
              sortedClothes.first.id; // Lock all except the first card
        }
      });
    } catch (e) {
      print("Error fetching donations: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
        builder: (context) => BloodCard(
          imageUrl: donation.imageUrl,
          title: donation.title,
          description: donation.description,
          projectvalue: donation.projectValue,
          paidvlaue: donation.paidValue,
          selectcategory: 'blood',
          screentitle: 'Blood Donation',
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
            const Text("Cart Screen"),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
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
      body: isLoading
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        const AlwaysStoppedAnimation<Color>(
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
    );
  }
}
