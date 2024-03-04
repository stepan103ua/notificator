import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notificator/core/mixins/with_side_effects.dart';

import 'callbacks/navigation_handler.dart';
import 'callbacks/snackbar_handler.dart';
import 'ui_events_side_effects.dart';

part 'ui_events_handler_state.dart';

class UiEventsHandlerCubit extends Cubit<UiEventsHandlerState>
    implements NavigationHandler, SnackBarHandler {
  UiEventsHandlerCubit() : super(const UiEventsHandlerState([]));

  @override
  void pushScreen(String screenName, [Object? arguments]) {
    emit(state.pushSideEffect(UiEventOpenScreen(screenName, arguments)));
  }

  @override
  void popScreen() {
    emit(state.pushSideEffect(const UiEventPopScreen()));
  }

  @override
  void showSnackBar(String message) {
    emit(state.pushSideEffect(UiEventShowSnackBar(message)));
  }
}
