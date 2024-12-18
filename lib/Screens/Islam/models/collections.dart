// import '../../../../routes/routes.dart';

class Collection {
  final String assetName;
  final String title;
  final String routeName;

  Collection(this.assetName, this.title, this.routeName);
}

List<Collection> collections = [
  Collection(
    'assets/images/collection_icon/svg/quran.svg',
    'Quran',
    'QuranMain',
    // RouteGenerator.quran,
  ),
  Collection(
    'assets/images/collection_icon/svg/hadees.svg',
    'Hadees',
    'HadithMain',
  ),
  Collection(
    'assets/images/collection_icon/svg/duas.svg',
    'Dua',
    // RouteGenerator.dua,
    'Coming Soon',
  ),
  Collection(
    'assets/images/collection_icon/svg/tasbih.svg',
    'Tasbih',
    // RouteGenerator.tasbih,
    'LocationApp',
  ),
  Collection(
    'assets/images/collection_icon/svg/allah.svg',
    '99 Names of Allah',
    // RouteGenerator.allahName,
    'NameAllahScreen',
  ),
  Collection(
    'assets/images/collection_icon/svg/prayer_time.svg',
    'Prayer Times',
    // RouteGenerator.prayerTimingPage,
    'PrayerTimingScreen',
  ),
  Collection(
    'assets/images/collection_icon/svg/kiblat.svg',
    'Qabah Direction',
    // RouteGenerator.qibla,
    'QiblaScreen',
  ),
  Collection(
    'assets/images/collection_icon/svg/other.svg',
    'Others',
    // 'Coming Soon',
    'Coming Soon',
  ),
];
