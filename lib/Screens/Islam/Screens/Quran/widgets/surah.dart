//   import 'dart:convert';

// import 'package:zakat_app/model/surah_model.dart';
// import 'package:http/http.dart' as http;
// Future<List<Surah>> fetchSurahs() async {
//     final response =
//         await http.get(Uri.parse('http://127.0.0.1:8000/islam/surah/'));

//     if (response.statusCode == 200) {
//       final List surahList = json.decode(response.body);
//       return surahList.map((json) => Surah.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load Surah data');
//     }
//   }