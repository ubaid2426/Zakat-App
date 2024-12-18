import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sadqahzakat/model/doantion_model.dart';
import 'package:sadqahzakat/model/name_allah.dart';

class DonationService {
  final String apiUrl = 'http://127.0.0.1:8000/data/donations/';

Future<List<DonationModel>> fetchDonations({
  required String sort,
  required String filter,
  String? category, // Optional category filter
  String? selectCategory, // Optional select category filter
}) async {
  // Build the URI with optional category and selectCategory filters
  final uri = Uri.parse('$apiUrl')
      .replace(queryParameters: {
    'sort': sort,
    'filter': filter,
    if (selectCategory != null) 'category_select': selectCategory,
    if (category != null) 'category': category,
  });

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final List<dynamic> donationData = json.decode(response.body);
    return donationData.map((data) => DonationModel.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load donations');
  }
}

}



class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/islam/name-allah/';

  // Function to fetch the data from API
  Future<AllahName> fetchNameAllah() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      return AllahName.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load name of Allah');
    }
  }
}