import 'dart:async';
import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  final TimingController controller;

  const CountDownTimer(this.controller, {super.key});

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  late Timer _timer;
  late Duration _timeRemaining;

  @override
  void initState() {
    super.initState();
    _timeRemaining = widget.controller.getTimeRemaining();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeRemaining = widget.controller.getTimeRemaining();
      });
      if (_timeRemaining.isNegative || _timeRemaining.inSeconds <= 0) {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Time Remaining:',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          _formatDuration(_timeRemaining),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.red),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}



class TimingController {
  final Map<String, String> timings; // Assuming this is a map of prayer names and times in string format

  TimingController(this.timings);

  Duration getTimeRemaining() {
    // Assume you're working with a map where the times are in "HH:mm" format
    String nextPrayerTimeString = timings['FajrStart'] ?? '00:00'; // Example key, use your actual key

    // Parse the time string into a DateTime object
    DateTime nextPrayerTime = DateTime.parse('2024-11-21 $nextPrayerTimeString:00'); // Using today’s date
    DateTime now = DateTime.now();

    // Calculate the difference between now and the next prayer time
    return nextPrayerTime.isAfter(now) ? nextPrayerTime.difference(now) : Duration.zero;
  }
}