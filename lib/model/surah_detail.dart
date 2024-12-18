// class SurahDetail {
//   final int id;
//   final int index;
//   final String name;
//   final List<String> verses;
//   final int count;

//   SurahDetail({
//     required this.id,
//     required this.index,
//     required this.name,
//     required this.verses,
//     required this.count,
//   });

//   factory SurahDetail.fromJson(Map<String, dynamic> json) {
//     return SurahDetail(
//       id: json['id'],
//       index: json['index'],
//       name: json['name'],
//       verses: (json['verse'] as Map<String, dynamic>)
//           .values
//           .map((e) => e.toString())
//           .toList(),
//       count: json['count'],
//     );
//   }
// }
