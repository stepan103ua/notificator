import 'package:equatable/equatable.dart';
import 'package:notificator/data/models/notification_model.dart';

class Notification extends Equatable {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final bool isRepeating;
  final bool isActive;

  const Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isRepeating,
    required this.isActive,
  });

  Notification copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    bool? isRepeating,
    bool? isActive,
  }) =>
      Notification(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        isRepeating: isRepeating ?? this.isRepeating,
        isActive: isActive ?? this.isActive,
      );

  NotificationModel toModel() => NotificationModel(
        id: id,
        title: title,
        description: description,
        date: date,
        isRepeating: isRepeating,
        isActive: isActive,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        isRepeating,
        isActive,
      ];
}
