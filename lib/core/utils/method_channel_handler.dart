import 'dart:async';

import 'package:flutter/services.dart';
import 'package:notificator/domain/entities/notification.dart';

enum ScheduleMethodChannelName {
  schedule('schedule');

  final String name;

  const ScheduleMethodChannelName(this.name);
}

sealed class NativeEvent {
  NativeEvent();

  factory NativeEvent.fromJson(dynamic data) {
    if (data is Map) {
      final id = data['alarm_item_id'] as int;
      return AlarmNotificationEvent(id: id);
    }

    throw Exception('Unknown event type: $data');
  }
}

class AlarmNotificationEvent extends NativeEvent {
  final int id;

  AlarmNotificationEvent({required this.id});

  AlarmNotificationEvent.fromJson(Map<String, dynamic> data)
      : id = data['alarm_item_id'] as int;
}

class MethodChannelHandler {
  final MethodChannel _platform;
  final StreamController<NativeEvent> _eventChannel =
      StreamController.broadcast();

  MethodChannelHandler({required MethodChannel platform})
      : _platform = platform;

  void setUpMethodChannel() {
    _platform.setMethodCallHandler((call) async {
      print('MethodChannelHandler: $call');
      if (call.method == 'onNotificationClick') {
        final id = call.arguments['alarm_item_id'] as int;
        print('Notification clicked: $id');
        _eventChannel.add(AlarmNotificationEvent(id: id));
      }
    });
  }

  Stream<NativeEvent> get notificationsStream => _eventChannel.stream;

  Future<void> scheduleNotification(Notification notification) =>
      _platform.invokeMethod(ScheduleMethodChannelName.schedule.name, {
        'id': notification.id,
        'time': notification.date.millisecondsSinceEpoch,
        'message': notification.description,
        'title': notification.title,
      });
}
