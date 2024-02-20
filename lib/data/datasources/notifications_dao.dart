import 'package:notificator/data/models/notification_model.dart';
import 'package:sqflite/sqflite.dart';

class NotificationsDao {
  static const tableName = 'Notifications';
  final Database _database;

  NotificationsDao({required Database database}) : _database = database;

  Future<Iterable<NotificationModel>> getNotifications() async {
    final rawNotifications = await _database.query(tableName);

    return rawNotifications.map(NotificationModel.fromJson);
  }

  Future<NotificationModel> getNotificationById(int id) async {
    final rawNotification = await _database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return NotificationModel.fromJson(rawNotification.first);
  }

  Future<void> addNotification(NotificationModel notification) =>
      _database.insert(tableName, notification.toJson());

  Future<void> updateNotification(NotificationModel notification) =>
      _database.update(
        tableName,
        notification.toJson(),
        where: 'id = ?',
        whereArgs: [notification.id],
      );

  Future<void> removeNotificationById(int id) => _database.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
}
