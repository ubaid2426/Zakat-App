import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/Islam/Screens/Quran/widgets/HadithScreen/Screens/bukhari_id_screen.dart';
import 'package:sadqahzakat/Screens/Islam/widgets/comming_soon_dialog.dart';
// import 'package:zakat_app/Screens/Islam/Screens/Quran/widgets/HadithScreen/Screens/bukhari_id_screen.dart';
// // Import the Muslim screen here
// import 'package:zakat_app/Screens/Islam/Screens/Quran/widgets/HadithScreen/Screens/muslim_id_screen.dart';
// import 'package:zakat_app/Screens/Islam/widgets/comming_soon_dialog.dart';

void main() {
  runApp(const HadithMain());
}

class HadithMain extends StatelessWidget {
  const HadithMain({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // MaterialApp(
        //   debugShowCheckedModeBanner: false,
        Scaffold(
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
        title: const Text('Islamic Books'),
        centerTitle: true,
      ),
      body: const IslamicBooksGrid(),
    );
    // );
  }
}

class IslamicBooksGrid extends StatelessWidget {
  const IslamicBooksGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // List of books with image paths and associated screens
    final List<Map<String, dynamic>> books = [
      {
        'image': 'Assests/images/HadithCard/bukhari.jpg',
        'screen': const BukhariIdScreen(),
      },
      {
        'image': 'Assests/images/HadithCard/muslim.jpg',
        'screen':
            const ComingSoonDialog(), // Replace with the actual Muslim screen
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the appropriate screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => book['screen'],
                ),
              );
            },
            child: IslamicBookImageCard(imagePath: book['image']),
          );
        },
      ),
    );
  }
}

class IslamicBookImageCard extends StatelessWidget {
  final String imagePath;

  const IslamicBookImageCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
