class DonateModel {
  final String id;
  final String title;
  final String des;
  final String image;
  final String route;
  int? price;
  int? quantity;
  final String? age;
  final String? gender;
  final String? headingcategory;
  final String? selectcategory;
  final bool isZakat; // Add this flag for Zakat donations
  final bool isSadqah; // Add this flag for Zakat donations
  
  DonateModel({
    required this.id,
    required this.age,
    required this.gender,
    required this.headingcategory,
    required this.selectcategory,
    required this.title,
    required this.des,
    required this.image,
    required this.route,
    this.price,
    this.quantity,
    this.isSadqah = false,
    this.isZakat = false, // Default value is false (not Zakat)
  });
}
