import 'package:notificator/core/utils/method_channel_handler.dart';

abstract class NativeEventsRepository {
  Stream<NativeEvent> get nativeEvents;

  void setupMethodChannel();
}
