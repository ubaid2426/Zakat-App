import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:zakat_app/Screens/Islam/widgets/timming_bloc.dart';
class PrayerTimingWidget extends StatelessWidget {
  const PrayerTimingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Define geographical coordinates for the location
    Coordinates coordinates = Coordinates(21.1959, 72.7933); // Example for Karachi

    // Specify calculation parameters
    PrayerCalculationParameters params = PrayerCalculationMethod.karachi();
    params.madhab = PrayerMadhab.hanafi;

    return BlocProvider(
      create: (_) => TimingBloc(coordinates, params),
      child: BlocListener<TimingBloc, TimingState>(
        listener: (context, state) {
          if (state is TimingInitial) {
            // Dispatch LoadTimingEvent here after bloc is initialized
            BlocProvider.of<TimingBloc>(context).add(LoadTimingEvent());
          }
        },
        child: GestureDetector(
          onTap: () {
            // Navigate to prayer timing page (ensure this route is defined)
            // Navigator.of(context).pushNamed('/prayerTimingPage');
          },
          child: SingleChildScrollView( // Make content scrollable
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTodayDate(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Next Prayer Timing:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                // BlocBuilder to handle the timer
                BlocBuilder<TimingBloc, TimingState>(
                  builder: (context, state) {
                    if (state is TimingInitial) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TimingLoaded) {
                      // Extract prayer times from the state
                      final prayerTimes = state.prayerTimes;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Show the prayer times
                          Text(
                            'Fajr Start Time: ${prayerTimes.fajrStartTime ?? 'N/A'}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Sunrise Time: ${prayerTimes.sunrise ?? 'N/A'}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Dhuhr Start Time: ${prayerTimes.dhuhrStartTime ?? 'N/A'}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Asr Start Time: ${prayerTimes.asrStartTime ?? 'N/A'}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Maghrib Start Time: ${prayerTimes.maghribStartTime ?? 'N/A'}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Isha Start Time: ${prayerTimes.ishaStartTime ?? 'N/A'}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      );
                    } else if (state is TimingError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else {
                      return const Center(child: Text('Unknown state'));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getTodayDate() {
    final now = DateTime.now();
    return '${now.day}/${now.month}/${now.year}';
  }
}
