class GetDonation {
  final String title;
  final String imageUrl;
  final double price;
  final bool isZakat;
  final bool isSadqah;
  final DateTime dateTime;
  final String status;
  final String age;
  final String gender;
  final String headingcategory;
  final String selectcategory;
  final String quantity;

  GetDonation({
    required this.age,
    required this.gender,
    required this.headingcategory,
    required this.selectcategory,
    required this.quantity,
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
      title: json['title'] ?? "", // Default to empty string if null
      status: json['payment_status'] ?? "", // Default to empty string
      imageUrl: json['imageUrl'] ?? "", // Default to empty string
      price: json['price'] != null ? double.tryParse(json['price'].toString()) ?? 0.0 : 0.0, // Safe parsing
      isZakat: json['isZakat'] ?? false, // Default to false
      isSadqah: json['isSadqah'] ?? false, // Default to false
      dateTime: json['dateTime'] != null
          ? DateTime.tryParse(json['dateTime']) ?? DateTime.now()
          : DateTime.now(), // Safe parsing with fallback to current time
      age: json['age'] ?? "", // Default to empty string
      gender: json['gender'] ?? "", // Default to empty string
      headingcategory: json['heading_category'] ?? "", // Default to empty string
      selectcategory: json['select_category'] ?? "", // Default to empty string
      quantity: json['quantity'] ?? "", // Default to empty string
    );
  }
}
