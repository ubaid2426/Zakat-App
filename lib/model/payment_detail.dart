class PaymentDetail {
  final String donorId;
  final String donorName;
  final double amount;
  final String donationTitle;
  final String paymentImage;

  PaymentDetail({
    required this.donorId,
    required this.donorName,
    required this.amount,
    required this.donationTitle,
    required this.paymentImage,
  });

  // Factory constructor for creating a new instance from a JSON object
  factory PaymentDetail.fromJson(Map<String, dynamic> json) {
    return PaymentDetail(
      donorId: json['donor_id'] ?? '',
      donorName: json['donor_name'] ?? '',
      amount: double.tryParse(json['amount']?.toString() ?? '0.0') ?? 0.0,
      donationTitle: json['donation_title'] ?? '',
      paymentImage: json['payment_image'] ?? '',
    );
  }

  // Method to convert the object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'donor_id': donorId,
      'donor_name': donorName,
      'amount': amount.toString(),
      'donation_title': donationTitle,
      'payment_image': paymentImage,
    };
  }
}
