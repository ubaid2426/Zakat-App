import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hijri_calendar/hijri_calendar.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sadqahzakat/Screens/Islam/widgets/timming_bloc.dart';

// import 'package:hijri_calendar/hijri_calendar.dart';
// import 'package:zakat_app/Screens/Islam/widgets/timming_bloc.dart';
final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

// ignore: constant_identifier_names
enum TimingProps { Fajr, Dhuhr, Asr, Maghrib, Isha }

class PrayerTimingScreen extends StatefulWidget {
  const PrayerTimingScreen({super.key});

  @override
  State<PrayerTimingScreen> createState() => _PrayerTimingScreenState();
}

class _PrayerTimingScreenState extends State<PrayerTimingScreen> {
  Timer? _timer;
  String _remainingTime = '';
  DateTime? _nextPrayerTime;
  TimingProps? _currentTiming;
  Position? _currentPosition;
  double? _latitude;
  double? _longitude;
  // late PrayerTimes prayerTimes;
  // void showPrayerTimeDifference(PrayerTimes prayerTimes) {

  // }
  Future<void> readPositionFromStorage() async {
    print(_latitude);
    print(_longitude);
    String? latStr = await _secureStorage.read(key: 'latitude');
    String? longStr = await _secureStorage.read(key: 'longitude');

    // double? latitude = latStr != null ? double.tryParse(latStr) : null;
    // double? longitude = longStr != null ? double.tryParse(longStr) : null;
    setState(() {
      _latitude = latStr != null ? double.tryParse(latStr) : null;
      _longitude = longStr != null ? double.tryParse(longStr) : null;
    });
    // debugPrint(latStr);
    // debugPrint(longStr);
    // return {'latitude': latitude, 'longitude': longitude};
  }

  final Map<TimingProps, String> _backgroundAsset = {
    TimingProps.Fajr: 'assets/images/praying_time/svg/morning.png',
    TimingProps.Dhuhr: 'assets/images/praying_time/svg/noon.png',
    TimingProps.Asr: 'assets/images/praying_time/svg/afternoon.png',
    TimingProps.Maghrib: 'assets/images/praying_time/svg/evening.png',
    TimingProps.Isha: 'assets/images/praying_time/svg/night.png',
  };

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    readPositionFromStorage();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _initializeLocation() async {
    final position = await _determinePosition();
    setState(() {
      _currentPosition = position;
    });
  }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_nextPrayerTime != null) {
        setState(() {
          _remainingTime = getRemainingTime(DateTime.now(), _nextPrayerTime!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultCoordinates = Coordinates(_latitude!, _longitude!);
    final currentCoordinates = _currentPosition != null
        ? Coordinates(_currentPosition!.latitude, _currentPosition!.longitude)
        : defaultCoordinates;
    // print("the crdinate is : ");
    print(currentCoordinates);
    // print("Coordinates: ${coordinates.latitude}, ${coordinates.longitude}");
    final params = PrayerCalculationMethod.karachi();
    params.madhab = PrayerMadhab.hanafi;

    return BlocProvider(
      create: (_) =>
          TimingBloc(defaultCoordinates, params)..add(LoadTimingEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Prayer Timing"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF33A248), Color(0xFFB2EA50)],
                begin: Alignment.topRight,
                end: Alignment.topLeft,
              ),
            ),
          ),
        ),
        body: _currentPosition == null
            ? const Center(child: CircularProgressIndicator())
            : BlocBuilder<TimingBloc, TimingState>(
                builder: (context, state) {
                  if (state is TimingInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TimingLoaded) {
                    final prayerTimes = state.prayerTimes;
                    final now = DateTime.now();
                    final nextPrayer = getNextPrayer(prayerTimes, now);

                    if (nextPrayer != null) {
                      _nextPrayerTime = nextPrayer['time'];
                      _currentTiming = nextPrayer['timing'];
                      _remainingTime = getRemainingTime(now, _nextPrayerTime!);
                    }

                    return Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  _backgroundAsset[_currentTiming] ??
                                      _backgroundAsset[TimingProps.Fajr]!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.black.withOpacity(0.6),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Date: ${HijriCalendarConfig.now().toFormat("dd MMMM yyyy")}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Next Prayer: ${nextPrayer?['name'] ?? 'Unknown'}: ${formatTime(_nextPrayerTime!)}',
                                  style: const TextStyle(
                                      fontSize: 24, color: Colors.green),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Time Remaining: $_remainingTime',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                const SizedBox(height: 16),
                                _buildPrayerTimings(prayerTimes),
                                // showPrayerTimeDifference(prayerTimes),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is TimingError) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const Center(child: Text('Unknown state'));
                  }
                },
              ),
      ),
    );
  }

  Widget _buildPrayerTimings(PrayerTimes prayerTimes) {
    final timings = {
      'Fajr': prayerTimes.fajrStartTime,
      'Dhuhr': prayerTimes.dhuhrStartTime,
      'Asr': prayerTimes.asrStartTime,
      'Maghrib': prayerTimes.maghribStartTime,
      'Isha': prayerTimes.ishaStartTime,
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: Column(
        children: timings.entries.map((entry) {
          final time = entry.value != null ? formatTime(entry.value!) : '--';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  time,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Map<String, dynamic>? getNextPrayer(PrayerTimes prayerTimes, DateTime now) {
    final prayerSchedule = {
      TimingProps.Fajr: prayerTimes.fajrStartTime,
      TimingProps.Dhuhr: prayerTimes.dhuhrStartTime,
      TimingProps.Asr: prayerTimes.asrStartTime,
      TimingProps.Maghrib: prayerTimes.maghribStartTime,
      TimingProps.Isha: prayerTimes.ishaStartTime,
    };

    final upcomingPrayers = prayerSchedule.entries
        .where((entry) => entry.value != null && entry.value!.isAfter(now))
        .toList();

    if (upcomingPrayers.isEmpty) {
      final tomorrowFajr =
          prayerTimes.fajrStartTime?.add(const Duration(days: 1));
      return {'name': 'Fajr', 'time': tomorrowFajr, 'timing': TimingProps.Fajr};
    }

    upcomingPrayers.sort((a, b) => a.value!.compareTo(b.value!));
    final nextPrayer = upcomingPrayers.first;

    return {
      'name': nextPrayer.key.name,
      'time': nextPrayer.value,
      'timing': nextPrayer.key,
    };
  }

  String formatTime(DateTime time) {
    int hour = time.hour;
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour; // Handle midnight and noon
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  String getRemainingTime(DateTime now, DateTime prayerTime) {
    final duration = prayerTime.difference(now);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}
