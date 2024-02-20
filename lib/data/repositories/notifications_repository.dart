import 'package:notificator/domain/entities/notification.dart';

abstract class NotificationsRepository {
  Future<Iterable<Notification>> getNotifications();

  Future<Notification> getNotificationById(int id);

  Future<void> saveNotification(Notification notification);

  Future<void> updateNotification(Notification notification);

  Future<void> removeNotificationById(int id);
}