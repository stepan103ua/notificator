import 'package:notificator/domain/entities/notification.dart';

class NotificationModel extends Notification {

  const NotificationModel({
    required super.id,
    required super.title,
    required super.description,
    required super.date,
    required super.isRepeating,
    required super.isActive,
  });

  NotificationModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          date: DateTime.parse(json['date']),
          isRepeating: json['isRepeating'] == 1 ? true : false,
          isActive: json['isActive'] == 1 ? true : false,
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'date': date.toIso8601String(),
        'isRepeating': isRepeating ? 1 : 0,
        'isActive': isActive ? 1 : 0,
      };
}
