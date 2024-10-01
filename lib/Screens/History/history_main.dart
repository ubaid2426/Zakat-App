import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class History extends StatelessWidget {
//   const History({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: DonationHistory(),
//     );
//   }
// }

class DonationHistory extends StatefulWidget {
  const DonationHistory({super.key});

  @override
  _DonationHistoryState createState() => _DonationHistoryState();
}

class _DonationHistoryState extends State<DonationHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedYear = 'Financial Year 2024';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF33A248), // First color (#33A248)
                Color(0xFFB2EA50), // Second color (#B2EA50)
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
          tabs: [
            // const Tab(text: 'ONE-OFF'),
            const Tab(text: 'MONTHLY'),
            const Tab(text: 'WEEKLY'),
            const Tab(text: 'DAILY'),
            const Tab(text: 'OFFLINE'),
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
          // Dropdown to select financial year
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
          // Expanded Tab View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildNoDonationsFound(),
                _buildNoDonationsFound(),
                _buildNoDonationsFound(),
                _buildNoDonationsFound(),
                // _buildNoDonationsFound(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget to display "No donations found" message
  Widget _buildNoDonationsFound() {
    return const Center(
      child: Text(
        'No donations found',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
