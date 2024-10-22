import 'dart:convert';
// import 'dart:io' as io;
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart'; // For image and video picking
import 'dart:io'; // To handle file inputs
import 'package:http/http.dart' as http; // To handle backend API
import 'package:geolocator/geolocator.dart';
import 'package:zakat_app/Screens/Login/Screen/login_page.dart';
import 'package:zakat_app/Screens/Message/user_services.dart'; // For location picking (optional)

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final List<Message1> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker(); // Image picker instance
  String? donorName; // To store donor's name
  int? donorId; // To store donor's ID
    bool isLoading = true;
  // Format the time to display in 'hh:mm a' format
  String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }


  @override
  void initState() {
    super.initState();
    _loadDonorDetails(); // Load donor details when the widget is initialized
  }

  // Function to send a message
  Future<void> _loadDonorDetails() async {
    var userDetails = await UserService.fetchUserDetails(); // Fetch details from the service
    if (userDetails != null) {
      setState(() {
        donorName = userDetails['name']; // Set donor's name
        donorId = userDetails['id'];     // Set donor's ID
        isLoading = false;
      });
    } else {
      print("Error fetching donor details.");
    }
  }

  // Send text message
  Future<void> sendMessage(String text) async {
    if (text.isEmpty || donorName == null || donorId == null) return;

    // Retrieve token from secure storage
    String? token = await storage.read(key: 'access_token');

    // Ensure the token is available
    if (token == null) {
      print("Token not found, unable to send message.");
      return;
    }

    var response = await http.post(
      Uri.parse('http://127.0.0.1:8000/chat/message/'),
      headers: {
        'Authorization': 'JWT $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'text': text,
        'sender': donorName,         // Use donor's name
        'sender_id': donorId,        // Use donor's ID
        // 'receiver_id': widget.receiverId, // Include receiver ID if available
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        messages.add(Message1(
          text: text,
          sender: donorName ?? 'Donor',  // Display donor's name
          seen: false,
          time: DateTime.now(),
        ));
      });
      _controller.clear();
    } else {
      print("Failed to send message: ${response.statusCode}");
    }
  }

  // Pick an image from the gallery
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      // Send image to backend
      uploadMedia(imageFile, 'image');
    }
  }

  // Pick a video from the gallery
  Future<void> pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      File videoFile = File(pickedFile.path);
      // Send video to backend
      uploadMedia(videoFile, 'video');
    }
  }

  // Simulate picking the location
  Future<void> pickLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String location = '${position.latitude}, ${position.longitude}';
    // Send location to backend
    sendMessage('Location: $location');
  }

  // Simulate picking audio (this can be extended using a plugin for audio)
  void pickAudio() {
    sendMessage('Audio message sent');
  }

  // Function to upload media (image or video) with token-based authentication
  Future<void> uploadMedia(File file, String type) async {
    if (donorName == null || donorId == null) {
      print("Donor details not available.");
      return;
    }

    // Retrieve token from secure storage
    String? token = await storage.read(key: 'access_token');
    print('Retrieved Token: $token');

    // Ensure the token is available
    if (token == null) {
      print("Token not found, unable to upload media.");
      return;
    }

    var request = http.MultipartRequest(
      'POST', Uri.parse('http://127.0.0.1:8000/chat/message/'),
    );
    request.headers['Authorization'] = 'JWT $token';
    request.files.add(await http.MultipartFile.fromPath(type, file.path));
    request.fields['sender'] = donorName!;  // Use donor's name
    request.fields['sender_id'] = donorId.toString();  // Use donor's ID
    // request.fields['receiver_id'] = widget.receiverId; // Include receiver ID
    request.fields['type'] = type;  // Either 'image' or 'video'

    var response = await request.send();

    if (response.statusCode == 201) {
      print('$type uploaded successfully!');
      setState(() {
        messages.add(Message1(
          text: '$type uploaded',
          sender: donorName!,  // Display donor's name
          seen: false,
          time: DateTime.now(),
        ));
      });
    } else {
      print("Failed to upload $type: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF33A248), Color(0xFFB2EA50)],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  leading: message.sender == 'Admin'
                      ? CircleAvatar(child: Icon(Icons.admin_panel_settings))
                      : CircleAvatar(child: Icon(Icons.person)),
                  title: Align(
                    alignment: message.sender == 'Donor'
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message.sender == 'Donor'
                            ? Colors.grey[200]
                            : Colors.green[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.text,
                            style: TextStyle(fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formatTime(message.time),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Icon(
                                message.seen
                                    ? Icons.done_all
                                    : Icons.done_all_outlined,
                                color: message.seen ? Colors.blue : Colors.grey,
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      messages[index].seen = true;
                    });
                  },
                );
              },
            ),
          ),
          // Input Section for new messages and media
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 50),
            child: Row(
              children: [
                // Media Icons
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: pickImage,
                ),
                IconButton(
                  icon: Icon(Icons.videocam),
                  onPressed: pickVideo,
                ),
                IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: pickLocation,
                ),
                IconButton(
                  icon: Icon(Icons.audiotrack),
                  onPressed: pickAudio,
                ),
                // Message Input
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                // Send Button
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Message Model
class Message1 {
  final String text;
  final String sender;
  bool seen;
  final DateTime time;

  Message1({
    required this.text,
    required this.sender,
    required this.seen,
    required this.time,
  });
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Message(),
  ));
}
