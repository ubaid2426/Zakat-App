class CompleteProject {
  final int id;
  final String image;
  final String text1;
  final String text2;
  final String detail;

  CompleteProject({
    required this.id,
    required this.image,
    required this.text1,
    required this.text2,
    required this.detail,
  });

  // Factory method to parse JSON data
  factory CompleteProject.fromJson(Map<String, dynamic> json) {
    return CompleteProject(
      id: json['id'],
      image: json['image'],
      text1: json['text1'],
      text2: json['text2'],
      detail: json['detail'],
    );
  }
}
