import 'package:notificator/data/models/notification_model.dart';
import 'package:notificator/data/repositories/notifications_repository.dart';
import 'package:notificator/domain/entities/notification.dart';
import 'package:uuid/uuid.dart';

import 'save_notification_request.dart';

class SaveNotificationUseCase {
  final NotificationsRepository _notificationRepository;
  final Uuid _uuid;

  SaveNotificationUseCase({
    required NotificationsRepository notificationRepository,
    required Uuid uuid,
  })  : _notificationRepository = notificationRepository,
        _uuid = uuid;

  Future<Notification> call(SaveNotificationRequest request) async {
    final id = _uuid.v4().hashCode;

    final notification = NotificationModel(
      id: id,
      title: request.title,
      description: request.description,
      date: request.date,
      isRepeating: request.isRepeating,
      isActive: request.isActive,
    );

    await _notificationRepository.saveNotification(notification);

    return notification;
  }
}
