import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:prayers_times/prayers_times.dart';

// 1. Define the possible states
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

// 2. Define the events (optional for more granular control)
abstract class TimingEvent {}

class LoadTimingEvent extends TimingEvent {}

// 3. Create the TimingBloc to handle the logic
class TimingBloc extends Bloc<TimingEvent, TimingState> {
  final Coordinates coordinates;
  final PrayerCalculationParameters params;

  TimingBloc(this.coordinates, this.params) : super(TimingInitial());

  Stream<TimingState> mapEventToState(TimingEvent event) async* {
    if (event is LoadTimingEvent) {
      try {
        // Fetch prayer times for today
        PrayerTimes prayerTimes = PrayerTimes(
          coordinates: coordinates,
          calculationParameters: params,
          precision: true,
          locationName: 'Asia/Karachi',
        );

        yield TimingLoaded(prayerTimes);
      } catch (e) {
        yield TimingError(e.toString());
      }
    }
  }
}
