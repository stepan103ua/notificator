import 'package:flutter/services.dart';
import 'package:notificator/domain/entities/notification.dart';

enum ScheduleMethodChannelName {
  schedule('schedule');

  final String name;

  const ScheduleMethodChannelName(this.name);
}

class MethodChannelHandler {
  final MethodChannel _platform;

  MethodChannelHandler({required MethodChannel platform})
      : _platform = platform;

  Future<void> scheduleNotification(Notification notification) =>
      _platform.invokeMethod(ScheduleMethodChannelName.schedule.name, {
        'id': notification.id,
        'time': notification.date.millisecondsSinceEpoch,
        'message': notification.description,
        'title': notification.title,
      });
}
