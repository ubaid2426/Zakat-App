class GetDonation {
  final String title;
  final String imageUrl;
  final double? price;
  final bool isZakat;
  final bool isSadqah;
  final DateTime dateTime;

  GetDonation({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.isZakat,
    required this.isSadqah,
    required this.dateTime,
  });

  factory GetDonation.fromJson(Map<String, dynamic> json) {
    return GetDonation(
      title: json['title'] ?? 'Unknown Title',
      imageUrl: json['imageUrl'] ?? '', // Use an empty string or default URL if null
      price: _toDouble(json['price']),
      isZakat: json['isZakat'] ?? false,
      isSadqah: json['isSadqah'] ?? false,
      dateTime: _toDateTime(json['dateTime']),
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
      return DateTime.tryParse(value) ?? DateTime.now(); // Try parsing or use current date
    } else if (value is DateTime) {
      return value;
    } else {
      return DateTime.now();
    }
  }

}