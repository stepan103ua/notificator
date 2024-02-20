import 'package:equatable/equatable.dart';

class SaveNotificationRequest extends Equatable {
  final String title;
  final String description;
  final DateTime date;
  final bool isRepeating;
  final bool isActive;

  const SaveNotificationRequest({
    required this.title,
    required this.description,
    required this.date,
    required this.isRepeating,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        date,
        isRepeating,
        isActive,
      ];
}
