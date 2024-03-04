import 'package:notificator/data/repositories/notifications_repository.dart';

class RemoveNotificationByIdUseCase {
  final NotificationsRepository _notificationRepository;

  RemoveNotificationByIdUseCase({
    required NotificationsRepository notificationRepository,
  }) : _notificationRepository = notificationRepository;

  Future<void> call(int id) =>
      _notificationRepository.removeNotificationById(id);
}
