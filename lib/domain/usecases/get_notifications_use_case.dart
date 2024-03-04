import 'package:notificator/data/repositories/notifications_repository.dart';
import 'package:notificator/domain/entities/notification.dart';

class GetNotificationsUseCase {
  final NotificationsRepository _notificationRepository;

  GetNotificationsUseCase({
    required NotificationsRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  Future<Iterable<Notification>> call() =>
      _notificationRepository.getNotifications();
}
