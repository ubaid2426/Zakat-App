import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prayers_times/prayers_times.dart';

// Define States
abstract class TimingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TimingInitial extends TimingState {}

class TimingLoaded extends TimingState {
  final PrayerTimes prayerTimes;

  TimingLoaded(this.prayerTimes);

  @override
  List<Object?> get props => [prayerTimes];
}

class TimingError extends TimingState {
  final String message;

  TimingError(this.message);

  @override
  List<Object?> get props => [message];
}

// Define Events
abstract class TimingEvent {}

class LoadTimingEvent extends TimingEvent {}

// Bloc Implementation
class TimingBloc extends Bloc<TimingEvent, TimingState> {
  final Coordinates coordinates;
  final PrayerCalculationParameters params;

  TimingBloc(this.coordinates, this.params) : super(TimingInitial()) {
    on<LoadTimingEvent>(_onLoadTimingEvent);
  }

  Future<void> _onLoadTimingEvent(
      LoadTimingEvent event, Emitter<TimingState> emit) async {
    try {
      // Initialize PrayerTimes for the current date
      final now = DateTime.now();
      final prayerTimes = PrayerTimes(
        coordinates: coordinates,
        calculationParameters: params,
        dateTime: now,
        precision: true,
        locationName: 'Asia/Karachi',
      );
  // print('\n***** Prayer Times');
  // print('Fajr Start Time:\t${prayerTimes.fajrStartTime!}');
  // print('Fajr End Time:\t${prayerTimes.fajrEndTime!}');
  // print('Sunrise Time:\t${prayerTimes.sunrise!}');
  // print('Dhuhr Start Time:\t${prayerTimes.dhuhrStartTime!}');
  // print('Dhuhr End Time:\t${prayerTimes.dhuhrEndTime!}');
  // print('Asr Start Time:\t${prayerTimes.asrStartTime!}');
  // print('Asr End Time:\t${prayerTimes.asrEndTime!}');
  // print('Maghrib Start Time:\t${prayerTimes.maghribStartTime!}');
  // print('Maghrib End Time:\t${prayerTimes.maghribEndTime!}');
  // print('Isha Start Time:\t${prayerTimes.ishaStartTime!}');
  // print('Isha End Time:\t${prayerTimes.ishaEndTime!}');
  // // print('Next Day Fajr Time:\t${prayerTimes1.fajrStartTime!}');
  // print('Tahajjud End Time:\t${prayerTimes.tahajjudEndTime!}');
  // print('Sehri End Time:\t${prayerTimes.sehri!}');
      emit(TimingLoaded(prayerTimes));
    } catch (e) {
      emit(TimingError('Failed to load prayer times: $e'));
    }
  }
}
