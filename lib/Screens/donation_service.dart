import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:sadqahzakat/Screens/Profile/profileScreen.dart';
// import 'package:sadqahzakat/Screens/Notification/Screen/notification.dart';
import 'package:sadqahzakat/model/complete_project.dart';
import 'package:sadqahzakat/model/doantion_model.dart';
import 'package:sadqahzakat/model/name_allah.dart';
import 'package:sadqahzakat/model/notification_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class DonationService {
  final String apiUrl = 'https://sadqahzakaat.com/data/donations/';

Future<List<DonationModel>> fetchDonations({
  required String sort,
  required String filter,
  String? category, // Optional category filter
  String? selectCategory, // Optional select category filter
}) async {
  // Build the URI with optional category and selectCategory filters
  final uri = Uri.parse(apiUrl)
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

Future<List<CompleteProject>> fetchProjects() async {
  final response = await http.get(Uri.parse('https://sadqahzakaat.com/data/items/'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => CompleteProject.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load projects');
  }
}

class ApiService {
  static const String baseUrl = 'https://sadqahzakaat.com/islam/name-allah/';

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


// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'notification_model.dart'; // Import your model

class NotificationService {
  final String baseUrl = 'https://sadqahzakaat.com/data';
  final storage = const FlutterSecureStorage(); // For accessing secure storage

  // Fetch Notifications
  Future<List<NotificationModel>> fetchNotifications() async {
    String? token = await storage.read(key: 'access_token');

    final response = await http.get(
      Uri.parse('$baseUrl/notifications/'),
      headers: {
        'Authorization': 'JWT $token', // Include the token in the headers
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => NotificationModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load notifications: ${response.body}');
    }
  }

  // Add Notification
  Future<void> addNotification(NotificationModel notification) async {
    String? token = await storage.read(key: 'access_token');
    final response = await http.post(
      Uri.parse('$baseUrl/notifications/'),
      headers: {
        'Authorization': 'Token $token', // Include the token in the headers
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'message': notification.message,
        // 'title': notification.title,
        // 'created_at' : notification.createdAt,
        // 'is_read': notification.isRead,
        'user': 11, // Pass the actual user ID
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add notification: ${response.body}');
    }
  }
}
