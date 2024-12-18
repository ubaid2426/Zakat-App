class GetDonation {
  final String title;
  final String imageUrl;
  final double price;
  final bool isZakat;
  final bool isSadqah;
  final DateTime dateTime;
  final String status;

  GetDonation({
    required this.title,
    required this.status,
    required this.imageUrl,
    required this.price,
    required this.isZakat,
    required this.isSadqah,
    required this.dateTime,
  });

  factory GetDonation.fromJson(Map<String, dynamic> json) {
    return GetDonation(
      title: json['title'] as String,
      status: json['payment_status'] as String,
      imageUrl: json['imageUrl'] as String,
      price: double.parse(json['price'] as String),
      isZakat: json['isZakat'] as bool,
      isSadqah: json['isSadqah'] as bool,
      dateTime: DateTime.parse(json['dateTime'] as String),
    );
  }
  // Helper method to convert to double or null
  static double? _toDouble(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value);
    } else {
      return null;
    }
  }

  static DateTime _toDateTime(dynamic value) {
    if (value == null) {
      return DateTime.now(); // Default to current date if null
    } else if (value is String) {
      return DateTime.tryParse(value) ??
          DateTime.now(); // Try parsing or use current date
    } else if (value is DateTime) {
      return value;
    } else {
      return DateTime.now();
    }
  }
}
