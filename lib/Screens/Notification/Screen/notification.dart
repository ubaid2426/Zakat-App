import 'package:flutter/material.dart';

// Data model for notifications
class NotificationModel {
  final String title;
  final String message;
  final DateTime date;
  final bool isRead;

  NotificationModel({
    required this.title,
    required this.message,
    required this.date,
    this.isRead = false,
  });
}


List<NotificationModel> notifications = [
  NotificationModel(
    title: "Donation Successful",
    message: "Your donation of \$100 has been successfully processed.",
    date: DateTime.now().subtract(const Duration(hours: 1)),
    isRead: true,
  ),
  NotificationModel(
    title: "Monthly Donation Reminder",
    message: "It's time to make your monthly donation.",
    date: DateTime.now().subtract(const Duration(days: 1)),
    isRead: false,
  ),
  NotificationModel(
    title: "New Campaign Launched",
    message: "Check out our latest donation campaign to support education.",
    date: DateTime.now().subtract(const Duration(days: 2)),
    isRead: false,
  ),
];

class NotificationMain extends StatelessWidget {
  const NotificationMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
            flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF33A248), // First color (#33A248)
                  Color(0xFFB2EA50), // Second color (#B2EA50)
                ],
                begin: Alignment
                    .bottomRight, // Start the gradient from bottom-right
                end: Alignment.topLeft, // End the gradient at top-left
              ),
            ),
          ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationItem(notification: notification);
        },
      ),
    );
  }
}

// Widget to show individual notification
class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          notification.isRead ? Icons.done_all : Icons.notifications,
          color: notification.isRead ? Colors.green : Colors.grey,
        ),
        title: Text(notification.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(notification.message),
        trailing: Text(
          "${notification.date.day}/${notification.date.month}/${notification.date.year}",
          style: const TextStyle(fontSize: 12.0),
        ),
        tileColor: notification.isRead ? Colors.grey.shade200 : Colors.white,
        onTap: () {
          // Handle notification tap
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Tapped on ${notification.title}'),
          ));
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NotificationMain(),
  ));
}
