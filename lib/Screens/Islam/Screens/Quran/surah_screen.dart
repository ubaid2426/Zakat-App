import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sadqahzakat/Screens/Islam/Screens/Quran/widgets/settting_screen.dart';
import 'package:sadqahzakat/model/surah_model.dart';
// import 'package:zakat_app/Screens/Islam/Screens/Quran/widgets/settting_screen.dart';
// import 'package:zakat_app/model/surah_model.dart';
// import 'package:zakat_app/Screens/Profile/Screens/setting.dart';

class SurahScreen extends StatefulWidget {
  final int surahId;
  final List<Surah> surahList;
  const SurahScreen({super.key, required this.surahId, required this.surahList});

  @override
  State<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {
  late Future<List<Verse>> verses; // To store the list of verses

  @override
  void initState() {
    super.initState();
    verses = fetchSurahDetails();
  }

  // Function to fetch Surah data from the API
Future<List<Verse>> fetchSurahDetails() async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/islam/surah-detail/${widget.surahId}/'),
  );

  if (response.statusCode == 200) {
    final decodedBody = utf8.decode(response.bodyBytes);
    final jsonData = json.decode(decodedBody);

    // Parse Arabic and English verses
    final verseArMap = jsonData['verse_ar'] as Map<String, dynamic>;
    final verseEnMap = jsonData['verse_en'] as Map<String, dynamic>;

    // Create a list of Verse objects
    final List<Verse> verses = [];
    verseArMap.forEach((key, arabicText) {
      final englishText = verseEnMap[key] ?? '';
      verses.add(Verse(arabicText: arabicText, transliteration: englishText));
    });

    return verses;
  } else {
    throw Exception('Failed to load Surah details');
  }
}


// index
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Surah Al-Fatihah',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuranSetting()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              // Add bookmarking functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Surah Info Section
          Container(
            color: Colors.green,
            padding: const EdgeInsets.all(16.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Makkah - 7 ayat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'الفاتحة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // TabBar-like Navigation
          Container(
            height: 70,
            color: Colors.green.shade100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      side: const BorderSide(
                          color: Colors.green,
                          width: 2), // Border color and width
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50), // Rounded corners
                      ),
                    ),
                    child: const Text('1. Surah Al-Fatihah'),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      side: const BorderSide(
                          color: Colors.green,
                          width: 2), // Border color and width
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50), // Rounded corners
                      ),
                    ),
                    child: const Text('2. Surah Al-Baqara'),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      side: const BorderSide(
                          color: Colors.green,
                          width: 2), // Border color and width
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(50), // Rounded corners
                      ),
                    ),
                    child: const Text('3. Surah Al-Imran'),
                  ),
                ],
              ),
            ),
          ),

          // Playback Controls
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.volume_up, color: Colors.green, size: 30),
                const Text("00:00"),
                IconButton(
                  icon: const Icon(Icons.play_arrow,
                      color: Colors.green, size: 30),
                  onPressed: () {
                    // Add playback functionality
                  },
                ),
                const Text("00:51"),
              ],
            ),
          ),

          // List of Verses
          Expanded(
            child: FutureBuilder<List<Verse>>(
              future: verses,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error.toString()}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No verses available'));
                } else {
                  final verseList = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    itemCount: verseList.length,
                    itemBuilder: (context, index) {
                      final verse = verseList[index];
                      return VerseWidget(
                        arabicText: verse.arabicText,
                        transliteration: verse.transliteration,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Verse Model Class
class Verse {
  final String arabicText;
  final String transliteration;

  Verse({
    required this.arabicText,
    required this.transliteration,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      arabicText: json['verse_ar'] as String,
      transliteration: json['verse_en'] as String,
    );
  }
}


// Updated VerseWidget to include both Arabic and English text in the same card
class VerseWidget extends StatelessWidget {
  final String arabicText;
  final String transliteration;
  const VerseWidget({
    super.key,
    required this.arabicText,
    required this.transliteration,
  });

  @override
  Widget build(BuildContext context) {
    // print(arabicText);
    // print(transliteration);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Arabic text
            Text(
              arabicText,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: 'Uthman',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8.0),

            // English transliteration
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                transliteration,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Verse Widget for display
// class VerseWidget extends StatelessWidget {
//   final String arabicText;
//   final String transliteration;
//   // final String translation;

//   const VerseWidget({
//     super.key,
//     required this.arabicText,
//     required this.transliteration,
//     // required this.translation,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16.0),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               arabicText,
//               textAlign: TextAlign.right,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontFamily: 'Uthman',
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             Text(
//               transliteration,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontStyle: FontStyle.italic,
//                 color: Colors.black54,
//               ),
//             ),
//             const SizedBox(height: 8.0),
//             // Text(
//             //   translation,
//             //   style: const TextStyle(
//             //     fontSize: 14,
//             //     color: Colors.black54,
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
