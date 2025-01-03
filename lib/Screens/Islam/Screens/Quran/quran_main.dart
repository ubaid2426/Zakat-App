import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sadqahzakat/Screens/Islam/Screens/Quran/surah_screen.dart';
// import 'package:zakat_app/Scre/surah_model.dart';
import 'dart:convert';

import 'package:sadqahzakat/model/surah_model.dart';
// import 'surah.dart'; // Import the Surah model

class QuranMain extends StatefulWidget {
  const QuranMain({super.key});

  @override
  _QuranMainState createState() => _QuranMainState();
}

class _QuranMainState extends State<QuranMain> {
  late Future<List<Surah>> surahList;
  late Future<List<Map<String, String>>> juzList;
  // final List<Surah> surahList1;
  @override
  void initState() {
    super.initState();
    surahList = fetchSurahs();
    juzList = fetchJuzs();
  }

  // Fetch Surah data from backend
  Future<List<Surah>> fetchSurahs() async {
    final response =
        await http.get(Uri.parse('https://sadqahzakaat.com/islam/surah/'));
    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final List surahJson = json.decode(decodedBody);
      return surahJson.map((json) => Surah.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Surah data');
    }
  }

  // Fetch Juz data (mock implementation)
  Future<List<Map<String, String>>> fetchJuzs() async {
    // Replace with actual API call if Juz data is available
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return List.generate(
      30,
      (index) => {
        "number": (index + 1).toString(),
        "name": "Juz ${index + 1} Name", // Replace with actual names
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: Surah and Juz
      child: Scaffold(
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
          title: const Text("Al-Qur'an"),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Surah",
              ),
              Tab(text: "Juz"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Surah Tab
            FutureBuilder<List<Surah>>(
              future: surahList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  final surahs = snapshot.data!;
                  return ListView.builder(
                    itemCount: surahs.length,
                    itemBuilder: (context, index) {
                      final surah = surahs[index];
                      // print(surah.arabicName);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            leading: CircleAvatar(
                              backgroundColor: Colors.green[100],
                              child: Text(
                                surah.number
                                    .toString(), // Convert int to String
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              surah.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              '${surah.place} - ${surah.ayah} ayat',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            trailing: Text(
                              surah.arabicName,
                              style: const TextStyle(
                                  fontSize: 20,
                                  // fontFamily: 'Amiri', // Arabic font
                                  fontFamily: 'Uthman'),
                            ),
                            onTap: () {
                              // Handle Surah Tap (e.g., navigate to details)
                              // print("check it" );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                         SurahScreen(surahId: surah.number, surahList: snapshot.data!,)), // Navigate to the screen
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),

            // Juz Tab
            FutureBuilder<List<Map<String, String>>>(
              future: juzList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  final juzs = snapshot.data!;
                  return ListView.builder(
                    itemCount: juzs.length,
                    itemBuilder: (context, index) {
                      final juz = juzs[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Text(
                            juz['number']!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          "Juz ${juz['number']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(juz['name']!),
                        onTap: () {
                          // Handle Juz Tap (e.g., navigate to details)
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
