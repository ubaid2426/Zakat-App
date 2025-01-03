import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BukhariDetail extends StatefulWidget {
  final String chapterid; // Passed chapter ID

  const BukhariDetail({super.key, required this.chapterid});

  @override
  _BukhariDetailState createState() => _BukhariDetailState();
}

class _BukhariDetailState extends State<BukhariDetail> {
  late Future<List<Hadith>> filteredHadiths;

  @override
  void initState() {
    super.initState();
    filteredHadiths = fetchFilteredHadiths();
  }

  Future<List<Hadith>> fetchFilteredHadiths() async {
    final response = await http
        .get(Uri.parse('https://sadqahzakaat.com/islam/upload-hadith-data/'));

    if (response.statusCode == 200) {
      // Decode the JSON response
      final decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> jsonData = json.decode(decodedBody);

      // Initialize a list to collect Hadiths
      List<Hadith> allHadiths = [];
      for (var item in jsonData) {
        if (item['hadiths'] != null) {
          final List<dynamic> hadithsList = item['hadiths'];
          allHadiths
              .addAll(hadithsList.map((h) => Hadith.fromJson(h)).toList());
        }
      }

      // Filter Hadiths based on the provided chapter ID
      return allHadiths
          .where((hadith) => hadith.chapterId == widget.chapterid)
          .toList();
    } else {
      throw Exception('Failed to load Hadiths');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hadiths'),
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
      ),
      body: FutureBuilder<List<Hadith>>(
        future: filteredHadiths,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Hadiths found'));
          }

          final hadithList = snapshot.data!;

          return ListView.builder(
            itemCount: hadithList.length,
            itemBuilder: (context, index) {
              final hadith = hadithList[index];

              return Card(
                margin: EdgeInsets.all(10),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hadith.arabicHadith,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontFamily: 'Noto',
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Narrator: ${hadith.englishNarrator}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        hadith.englishText,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Hadith {
  final String chapterId;
  final String arabicHadith;
  final String englishNarrator;
  final String englishText;

  Hadith({
    required this.chapterId,
    required this.arabicHadith,
    required this.englishNarrator,
    required this.englishText,
  });

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      chapterId: json['chapter_id'].toString(), // Convert to string for comparison
      arabicHadith: json['arabic_hadith'] ?? '',
      englishNarrator: json['english_narrator'] ?? '',
      englishText: json['english_text'] ?? '',
    );
  }
}
