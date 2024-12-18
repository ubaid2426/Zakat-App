class Surah {
  final int number;
  final String name;
  final String place;
  final int ayah;
  final String arabicName;

  Surah({
    required this.number,
    required this.name,
    required this.place,
    required this.ayah,
    required this.arabicName,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['id'],
      name: json['transliteration'],
      place: json['type'],
      ayah: json['total_verses'],
      arabicName: json['name'],
    );
  }
}