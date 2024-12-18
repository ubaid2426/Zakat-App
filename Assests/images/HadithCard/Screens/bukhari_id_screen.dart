import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Bukhari_Id_Screen extends StatefulWidget {
  const Bukhari_Id_Screen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Bukhari_Id_ScreenState createState() => _Bukhari_Id_ScreenState();
}

// ignore: camel_case_types
class _Bukhari_Id_ScreenState extends State<Bukhari_Id_Screen> {
  Future<List<dynamic>> fetchChapters() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/islam/upload-hadith-data/'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load chapters');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chapters'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchChapters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
                return ListTile(
                  title: Text(
                    'Chapter ${chapter['chapter_id']}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    chapter['arabic_introduction'] ?? 'No Arabic introduction',
                  ),
                  trailing: Text(
                    'Length: ${chapter['length']}',
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

void main() => runApp(MaterialApp(home: Bukhari_Id_Screen()));
