import 'package:equatable/equatable.dart';

class Time extends Equatable {
  final int hour;
  final int minute;

  const Time({required this.hour, required this.minute});

  Duration toDuration() => Duration(hours: hour, minutes: minute);

  @override
  List<Object?> get props => [hour, minute];
}
