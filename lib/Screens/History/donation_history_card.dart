import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DonationHistoryCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final double? price;
  final bool isZakat;
  final bool isSadqah;
  final DateTime dateTime;
  const DonationHistoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.isZakat,
    required this.isSadqah,
    required this.dateTime,
  });

  @override
  State<DonationHistoryCard> createState() => _DonationHistoryCardState();
}

class _DonationHistoryCardState extends State<DonationHistoryCard> {
 String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.imageUrl);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Title Bar
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 137, 212, 63),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Content Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 10),

              // Image Section
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 188, 2),
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(
                      "http://127.0.0.1:8000${widget.imageUrl}",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 100,
                height: 100,
              ),

              const SizedBox(width: 20),

              // Info Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Donation Cost",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 85, 84, 84),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "\$${widget.price}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Donation Type Tags
                    Row(
                      children: [
                        if (widget.isZakat) _buildTag("Zakat Donation"),
                        const SizedBox(width: 5),
                        if (widget.isSadqah) _buildTag("Sadqah Donation"),
                      ],
                    ),

                    // Date and Time
                    const SizedBox(height: 5),
                    Text(
                      formatTime(widget.dateTime),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
