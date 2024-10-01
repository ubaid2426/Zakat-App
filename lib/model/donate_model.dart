class DonateModel {
  final String id;
  final String title;
  final String des;
  final String image;
  final String route;
   int price;
  final bool isZakat; // Add this flag for Zakat donations

  DonateModel({
    required this.id,
    required this.title,
    required this.des,
    required this.image,
    required this.route,
    required this.price,
    this.isZakat = false, // Default value is false (not Zakat)
  });
}
