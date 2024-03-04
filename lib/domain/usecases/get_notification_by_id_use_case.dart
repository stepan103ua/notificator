import 'package:notificator/data/repositories/notifications_repository.dart';
import 'package:notificator/domain/entities/notification.dart';

class GetNotificationByIdUseCase {
  final NotificationsRepository _notificationRepository;

  GetNotificationByIdUseCase({
    required NotificationsRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  Future<Notification> call(int id) =>
      _notificationRepository.getNotificationById(id);
}
