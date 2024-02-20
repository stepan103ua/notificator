import 'package:notificator/data/repositories/notifications_repository.dart';

import '../entities/notification.dart';

class UpdateNotificationUseCase {
  final NotificationsRepository _notificationRepository;

  UpdateNotificationUseCase({
    required NotificationsRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  Future<void> call(Notification notification) =>
      _notificationRepository.updateNotification(notification);
}
