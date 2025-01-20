import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notificator/core/mixins/with_side_effects.dart';
import 'package:notificator/core/utils/method_channel_handler.dart';
import 'package:notificator/data/repositories/native_events_repository.dart';

import 'native_event_side_effect.dart';

part 'native_event_state.dart';

class NativeEventCubit extends Cubit<NativeEventState> {
  final NativeEventsRepository _nativeEventsRepository;

  NativeEventCubit({required NativeEventsRepository nativeEventsRepository})
      : _nativeEventsRepository = nativeEventsRepository,
        super(const NativeEventState(sideEffects: [])) {
    _nativeEventsRepository.setupMethodChannel();

    _nativeEventsRepository.nativeEvents.listen((event) {
      print('NativeEventCubit: $event');
      if (event is AlarmNotificationEvent) {
        emit(state.pushSideEffect((NativeEventOpenAlarmScreen(event.id))));
      }
    });
  }
}
