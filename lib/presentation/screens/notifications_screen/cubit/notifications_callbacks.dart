import 'package:notificator/domain/entities/notification.dart';

abstract class NotificationsCallbacks {
  void onNotificationAdded(Notification notifications);
}