class AllahName {
  final String? icon;
  final String engName;
  final String engMeaning;
  final String explanation;

  AllahName({
     this.icon,
    required this.engName,
    required this.engMeaning,
    required this.explanation,
  });

  // From JSON
  factory AllahName.fromJson(Map<String, dynamic> json) {
    return AllahName(
      icon: json['icon']as String? ,
      engName: json['eng_name'] as String,
      engMeaning: json['eng_meaning'] as String,
      explanation: json['explanation'] as String,
    );
  }
}
