class DoantionModel {
  const DoantionModel( {
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.projectvalue,
    required this.paidvlaue,
    required this.date,
    required this.position,
  });
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final double projectvalue;
  final double paidvlaue;
    final DateTime date; 
      final int position; 

       double get remainingValue => projectvalue - paidvlaue;
}
