import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonationHistoryCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final double price;
  final bool isZakat;
  final bool isSadqah;
  final DateTime dateTime;
  final String? age;
  final String? gender;
  final String? headingcategory;
  final String? selectcategory;
  final String? quantity;
  final String? paymentStatus; // Added payment status to props
  const DonationHistoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.isZakat,
    required this.isSadqah,
    required this.dateTime,
    required this.paymentStatus,
    required this.age,
    required this.gender,
    required this.headingcategory,
    required this.selectcategory,
    required this.quantity, // Pass the payment status from outside
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
    print("Payment Status: ${widget.paymentStatus}");

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
                      "https://sadqahzakaat.com${widget.imageUrl}",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Donation Cost",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 85, 84, 84),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  "\$${widget.price.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(widget.quantity!)
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(
                            widget.paymentStatus ?? "Unknown Status",
                            style: TextStyle(
                              color: widget.paymentStatus == 'Pending'
                                  ? Colors.red
                                  : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (widget.isZakat) _buildTag("Zakat Donation"),
                        const SizedBox(width: 5),
                        if (widget.isSadqah) _buildTag("Sadqah Donation"),
                      ],
                    ),
                    if (widget.headingcategory!.isNotEmpty &&
                        widget.selectcategory!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.headingcategory!),
                            const SizedBox(width: 5),
                            Text(widget.selectcategory!),
                          ],
                        ),
                      ),
                    if (widget.gender!.isNotEmpty && widget.age!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.gender!),
                            const SizedBox(width: 5),
                            Text(widget.age!),
                          ],
                        ),
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
