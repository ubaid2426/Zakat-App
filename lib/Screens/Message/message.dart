import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting the time

class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  // Example message list, you can replace it with your backend data
  List<Message1> messages = [
    Message1(
        text: 'Hello Admin!',
        sender: 'Donor',
        seen: false,
        time: DateTime.now()),
    Message1(
        text: 'Hi, how can I help you?',
        sender: 'Admin',
        seen: true,
        time: DateTime.now()),
    Message1(
        text: 'I want to donate blood',
        sender: 'Donor',
        seen: false,
        time: DateTime.now()),
  ];

  final TextEditingController _controller =
      TextEditingController(); // Controller for input field

  // Simulate marking a message as seen
  void markAsSeen(int index) {
    setState(() {
      messages[index].seen = true;
    });
  }

  // Format the time to display in 'hh:mm a' format
  String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  // Function to send a message
  void sendMessage(String text) {
    if (text.isEmpty) return;
    setState(() {
      messages.add(
        Message1(
          text: text,
          sender: 'Donor', // Assuming 'Donor' is sending the message
          seen: false, // Initially set to not seen
          time: DateTime.now(), // Automatically pick the current time
        ),
      );
    });
    _controller.clear(); // Clear the input field after sending
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF33A248), // First color (#33A248)
                Color(0xFFB2EA50), // Second color (#B2EA50)
              ],
              begin:
                  Alignment.bottomRight, // Start the gradient from bottom-right
              end: Alignment.topLeft, // End the gradient at top-left
            ),
          ),
        ),
        // leading: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: const Icon(Icons.arrow_back),
        // ),
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
                                formatTime(
                                    message.time), // Display formatted time
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              // Double tick logic
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
                    markAsSeen(index); // Mark message as seen on tap
                  },
                );
              },
            ),
          ),
          // Input Section for new messages
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 50),
            child: Row(
              children: [
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
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_controller.text); // Send the message on press
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
