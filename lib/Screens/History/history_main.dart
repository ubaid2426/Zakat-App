import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zakat_app/Screens/History/donation_history_card.dart';
import 'package:zakat_app/Screens/PaymentMethod/payment_method.dart';
import 'package:zakat_app/model/get_donation_model.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class DonationHistory extends StatefulWidget {
  const DonationHistory({super.key});

  @override
  _DonationHistoryState createState() => _DonationHistoryState();
}

class _DonationHistoryState extends State<DonationHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedYear = 'Financial Year 2024';
  late Future<List<GetDonation>> _donationHistory;

  List<GetDonation> dailyDonations = [];
  List<GetDonation> weeklyDonations = [];
  List<GetDonation> monthlyDonations = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _donationHistory = fetchDonationHistory();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List<GetDonation>> fetchDonationHistory() async {
        String? donorName = await storage.read(key: 'user_name');
        String? donorId = await storage.read(key: 'user_id');
    final response = await http.get(
        Uri.parse("http://127.0.0.1:8000/data/donation-history/$donorId/$donorName/"));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<GetDonation> donations =
          data.map((json) => GetDonation.fromJson(json)).toList();

      _filterDonationsByDate(donations);
      return donations;
    } else {
      throw Exception('Failed to load donation history');
    }
  }

  void _filterDonationsByDate(List<GetDonation> donations) {
    final today = DateTime.now();
    final startOfToday = DateTime(today.year, today.month, today.day);
    final startOfLastWeek = startOfToday.subtract(const Duration(days: 7));
    final startOfLastMonth = startOfToday.subtract(const Duration(days: 30));

    dailyDonations = donations
        .where((donation) =>
            donation.dateTime.year == today.year &&
            donation.dateTime.month == today.month &&
            donation.dateTime.day == today.day)
        .toList();

    weeklyDonations = donations
        .where((donation) => donation.dateTime.isAfter(startOfLastWeek) &&
            donation.dateTime.isBefore(startOfToday))
        .toList();

    monthlyDonations = donations
        .where((donation) => donation.dateTime.isAfter(startOfLastMonth) &&
            donation.dateTime.isBefore(startOfToday) &&
            !weeklyDonations.contains(donation))
        .toList();
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
        title: const Text('Donation History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.yellow,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.yellow,
          tabs: const [
            Tab(text: 'DAILY'),
            Tab(text: 'WEEKLY'),
            Tab(text: 'MONTHLY'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Handle download action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedYear,
                  items: <String>[
                    'Financial Year 2024',
                    'Financial Year 2023',
                    'Financial Year 2022'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedYear = newValue!;
                    });
                  },
                ),
                TextButton.icon(
                  onPressed: () {
                    // Handle download all action
                  },
                  icon: const Icon(Icons.download, color: Colors.green),
                  label: const Text(
                    'Download all',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<GetDonation>>(
              future: _donationHistory,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _buildDonationList(dailyDonations, 'No daily donations found'),
                      _buildDonationList(weeklyDonations, 'No weekly donations found'),
                      _buildDonationList(monthlyDonations, 'No monthly donations found'),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationList(List<GetDonation> donations, String emptyMessage) {
    if (donations.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: donations.length,
        itemBuilder: (context, index) {
          final donation = donations[index];
          return DonationHistoryCard(
            title: donation.title,
            imageUrl: donation.imageUrl,
            price: donation.price,
            isZakat: donation.isZakat,
            isSadqah: donation.isSadqah,
            dateTime: donation.dateTime,
          );
        },
      );
    }
  }
}
