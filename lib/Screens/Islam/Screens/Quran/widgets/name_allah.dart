import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sadqahzakat/model/name_allah.dart';
// import 'package:zakat_app/model/name_allah.dart';

class NameAllahScreen extends StatefulWidget {
  const NameAllahScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NameAllahScreenState createState() => _NameAllahScreenState();
}

class _NameAllahScreenState extends State<NameAllahScreen> {
  late Future<List<AllahName>> _allahNames;

  @override
  void initState() {
    super.initState();
    _allahNames = fetchData();
  }

  // Fetch data from API
  Future<List<AllahName>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://sadqahzakaat.com/islam/name-allah/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Parse the data list and convert it to a list of AllahName objects
      return data.map((item) => AllahName.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
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
          title: const Text("Allah's Names")),
      body: FutureBuilder<List<AllahName>>(
        future: _allahNames,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final names = snapshot.data!;
            return ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                final name = names[index];
                return Column(
                  children: [
                    _buildCartDetails(name),
                    _buildCartHeader(name.explanation),
                    const Divider(),
                    // SizedBox(height: 5,)
                  ],
                );
                // return ListTile(
                //   // leading: Image.network(name.icon!),
                //   title: Text(name.engName),
                //   subtitle: Text(name.engMeaning),
                //   isThreeLine: true,
                // );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildCartHeader(String title) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF89D43F),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
      height: 40,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20),
      child: Text(title, style: const TextStyle(fontSize: 14)),
    );
  }

  /// Builds the details for a cart item
  Widget _buildCartDetails(dynamic item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // const Text("Donation Cost", style: TextStyle(fontSize: 18)),
              Text(item.engName,
                  style:
                      const TextStyle(fontSize: 20, color: Color(0xFF7fc23a), fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(item.engMeaning,
                  style:
                      const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
            Container(
            width: 70,
            height: 70,
            // margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage("https://sadqahzakaat.com/data${item.icon}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
