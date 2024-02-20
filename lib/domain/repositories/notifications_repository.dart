import 'package:notificator/data/datasources/notifications_dao.dart';
import 'package:notificator/data/repositories/notifications_repository.dart';
import 'package:notificator/domain/entities/notification.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsDao _notificationsDao;

  NotificationsRepositoryImpl({required NotificationsDao notificationsDao})
      : _notificationsDao = notificationsDao;

  @override
  Future<Notification> getNotificationById(int id) =>
      _notificationsDao.getNotificationById(id);

  @override
  Future<Iterable<Notification>> getNotifications() =>
      _notificationsDao.getNotifications();

  @override
  Future<void> removeNotificationById(int id) =>
      _notificationsDao.removeNotificationById(id);

  @override
  Future<void> saveNotification(Notification notification) =>
      _notificationsDao.addNotification(notification.toModel());

  @override
  Future<void> updateNotification(Notification notification) =>
      _notificationsDao.updateNotification(notification.toModel());
}
