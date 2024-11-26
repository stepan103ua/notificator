import 'package:equatable/equatable.dart';
import 'package:notificator/domain/entities/side_effect.dart';

sealed class NativeEventSideEffect extends Equatable implements SideEffect {
  const NativeEventSideEffect();
}

class NativeEventOpenAlarmScreen extends NativeEventSideEffect {
  final int alarmId;

  const NativeEventOpenAlarmScreen(this.alarmId);

  @override
  List<Object?> get props => [alarmId];
}
