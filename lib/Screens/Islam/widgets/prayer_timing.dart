import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prayers_times/prayers_times.dart';
// import 'package:sadqahzakat/Screens/Islam/widgets/get_location.dart';
import 'package:sadqahzakat/Screens/Islam/widgets/timming_bloc.dart';

// import 'package:zakat_app/Screens/Islam/widgets/timming_bloc.dart';
final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

class PrayerTimingWidget extends StatefulWidget {
  const PrayerTimingWidget({super.key});

  @override
  State<PrayerTimingWidget> createState() => _PrayerTimingWidgetState();
}

class _PrayerTimingWidgetState extends State<PrayerTimingWidget> {
  Timer? _timer;
  String _remainingTime = '';
  DateTime? _nextPrayerTime;
  double? latitude;
  double? longitude;
  @override
  void initState() {
    super.initState();
    _startTimer();
    readPositionFromStorage();
    // const QiblaApp();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    // Refresh the UI every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_nextPrayerTime != null) {
        final now = DateTime.now();
        setState(() {
          _remainingTime = getRemainingTime(now, _nextPrayerTime!);
        });
      }
    });
  }

  Future<void> readPositionFromStorage() async {
    String? latStr = await _secureStorage.read(key: 'latitude');
    String? longStr = await _secureStorage.read(key: 'longitude');

    latitude = latStr != null ? double.tryParse(latStr) : null;
    longitude = longStr != null ? double.tryParse(longStr) : null;
  }

  @override
  Widget build(BuildContext context) {
    // print(latitude);
    // print(longitude);
    if (latitude == null || longitude == null) {
      // Fallback to a default location (e.g., Karachi) if coordinates are not available
      latitude = 31.5204; // Default latitude
      longitude = 74.3587; // Default longitude
    }
    // Define geographical coordinates for the location
    Coordinates coordinates =
        // Coordinates(31.5204, 74.3587); // Example for Karachi
        Coordinates(latitude!, longitude!); // Example for Karachi

    // Specify calculation parameters
    PrayerCalculationParameters params = PrayerCalculationMethod.karachi();
    params.madhab = PrayerMadhab.hanafi;

    return BlocProvider(
      create: (_) => TimingBloc(coordinates, params)..add(LoadTimingEvent()),
      child: BlocBuilder<TimingBloc, TimingState>(
        builder: (context, state) {
          if (state is TimingInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TimingLoaded) {
            // Extract prayer times from the state
            final prayerTimes = state.prayerTimes;
            final now = DateTime.now();

            // Determine the next prayer
            final nextPrayer = getNextPrayer(prayerTimes, now);

            if (nextPrayer != null) {
              _nextPrayerTime = nextPrayer['time'];
              _remainingTime = getRemainingTime(now, _nextPrayerTime!);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTodayDate(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Next Prayer Timing:',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                if (nextPrayer != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${nextPrayer['name']}: ${formatTime(_nextPrayerTime!)}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.green),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Time Remaining: $_remainingTime',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
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
    );
  }

  // Helper to calculate the next prayer time and remaining time
  Map<String, dynamic>? getNextPrayer(PrayerTimes prayerTimes, DateTime now) {
    final prayerSchedule = {
      'Fajr': prayerTimes.fajrStartTime,
      'Sunrise': prayerTimes.sunrise,
      'Dhuhr': prayerTimes.dhuhrStartTime,
      'Asr': prayerTimes.asrStartTime,
      'Maghrib': prayerTimes.maghribStartTime,
      'Isha': prayerTimes.ishaStartTime,
    };

    // Filter prayer times that are after the current time
    final upcomingPrayers = prayerSchedule.entries
        .where((entry) => entry.value != null && entry.value!.isAfter(now))
        .toList();

    // If no upcoming prayers today, show the first prayer of the next day
    if (upcomingPrayers.isEmpty) {
      final tomorrowFajr =
          prayerTimes.fajrStartTime?.add(const Duration(days: 1));
      return {
        'name': 'Fajr',
        'time': tomorrowFajr,
      };
    }

    // Sort by time
    upcomingPrayers.sort((a, b) => a.value!.compareTo(b.value!));

    // Get the next prayer
    final nextPrayer = upcomingPrayers.first;
    return {
      'name': nextPrayer.key,
      'time': nextPrayer.value,
    };
  }

  // Helper to format time
  String formatTime(DateTime time) {
    int hour = time.hour;
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour; // Convert 0 to 12 for 12-hour format
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  // Helper to get remaining time in hours, minutes, and seconds
  String getRemainingTime(DateTime now, DateTime prayerTime) {
    final duration = prayerTime.difference(now);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    return '${hours}h ${minutes}m ${seconds}s';
  }

  // Helper to get today's date in DD/MM/YYYY format
  String getTodayDate() {
    final now = DateTime.now();
    return '${now.day}/${now.month}/${now.year}';
  }
}
