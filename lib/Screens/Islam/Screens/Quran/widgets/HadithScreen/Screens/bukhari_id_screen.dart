import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sadqahzakat/Screens/Islam/Screens/Quran/widgets/HadithScreen/Screens/bukhari_detail_screen.dart';
// import 'package:zakat_app/Screens/Islam/Screens/Quran/widgets/HadithScreen/Screens/bukhari_detail_screen.dart';

class BukhariIdScreen extends StatefulWidget {
  const BukhariIdScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BukhariIdScreenState createState() => _BukhariIdScreenState();
}

class _BukhariIdScreenState extends State<BukhariIdScreen> {
  Future<List<dynamic>> fetchChapters() async {
    final response = await http.get(
      Uri.parse('https://sadqahzakaat.com/islam/upload-hadith-data/'),
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      // return jsonDecode(response.body);
      return jsonDecode(decodedBody);
    } else {
      throw Exception('Failed to load chapters');
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
        title: Text('Chapters'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchChapters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final chapters = snapshot.data!;
            return ListView.builder(
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final chapter = chapters[index];
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
                          "${chapter['id']}"
                              .toString(), // Convert int to String
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        chapter['english_introduction'] ??
                            'No English introduction',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text(
                          "${chapter['length']}",
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      trailing: Text(
                        chapter['arabic_introduction'] ??
                            'No Arabic introduction',
                        style: const TextStyle(
                            fontSize: 20,

                            // fontFamily: 'Amiri', // Arabic font
                            fontFamily: 'Uthman'),
                      ),
                      onTap: () {
                        // Handle Surah Tap (e.g., navigate to details)
                        print("check it");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BukhariDetail(
                              chapterid: chapter['id']
                                  .toString(), // Pass chapter ID as a string
                            ),
                          ), // Navigate to the screen
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
    );
  }
}

void main() => runApp(MaterialApp(home: BukhariIdScreen()));
