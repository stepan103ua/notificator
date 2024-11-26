import 'package:notificator/core/utils/method_channel_handler.dart';
import 'package:notificator/data/repositories/native_events_repository.dart';

class NativeEventsRepositoryImpl extends NativeEventsRepository {
  final MethodChannelHandler _methodChannelHandler;

  NativeEventsRepositoryImpl({
    required MethodChannelHandler methodChannelHandler,
  }) : _methodChannelHandler = methodChannelHandler;

  @override
  Stream<NativeEvent> get nativeEvents =>
      _methodChannelHandler.notificationsStream;

  @override
  void setupMethodChannel() {
    _methodChannelHandler.setUpMethodChannel();
  }
}
