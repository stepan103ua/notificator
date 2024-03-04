part of 'new_notification__cubit.dart';

class NewNotificationState extends Equatable {
  final FieldValue<String> title;
  final FieldValue<String> description;
  final FieldValue<DateTime?> date;
  final FieldValue<Time?> time;

  const NewNotificationState({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
  });

  const NewNotificationState.initial()
      : title = const FieldValue(value: ''),
        description = const FieldValue(value: ''),
        date = const FieldValue(value: null),
        time = const FieldValue(value: null);

  NewNotificationState copyWith({
    FieldValue<String>? title,
    FieldValue<String>? description,
    FieldValue<DateTime?>? date,
    FieldValue<Time?>? time,
  }) =>
      NewNotificationState(
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        time: time ?? this.time,
      );

  @override
  List<Object?> get props => [title, description, date, time];
}
