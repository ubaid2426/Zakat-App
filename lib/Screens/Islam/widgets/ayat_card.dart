import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/Islam/utils/sirat_card.dart';
// import 'package:zakat_app/Screens/Islam/utils/sirat_card.dart';

class AyatCard extends StatelessWidget {
  const AyatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SiratCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Quran Ayat of the Day',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const Divider(
            height: 25, // Replace with your desired height
          ),
          Column(
            children: [
              Text(
                'رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي وَاحْلُلْ عُقْدَةً مِنْ لِسَانِي يَفْقَهُوا قَوْلِي',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontFamily: 'Uthman',
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32, // Replace with your desired height
              ),
              Text(
                '“My Lord, expand for me my breast [with assurance] and ease for me my task and untie the knot from my tongue that they may understand my speech.”',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 64, // Replace with your desired height
              ),
              Text(
                'Surah Taha, Verse 25-28',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
