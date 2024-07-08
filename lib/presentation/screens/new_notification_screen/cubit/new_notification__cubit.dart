import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notificator/core/data/models/field_value.dart';
import 'package:notificator/core/data/models/time.dart';
import 'package:notificator/core/ui_events_handler/callbacks/navigation_handler.dart';
import 'package:notificator/core/ui_events_handler/callbacks/snackbar_handler.dart';
import 'package:notificator/core/utils/validation_utils.dart';
import 'package:notificator/domain/usecases/save_notification_use_case/save_notification_request.dart';
import 'package:notificator/domain/usecases/save_notification_use_case/save_notification_use_case.dart';
import 'package:notificator/presentation/screens/notifications_screen/cubit/notifications_callbacks.dart';

part 'new_notification__state.dart';

class NewNotificationCubit extends Cubit<NewNotificationState> {
  final NavigationHandler _navigationHandler;
  final SnackBarHandler _snackBarHandler;
  final SaveNotificationUseCase _saveNotificationUseCase;
  final NotificationsCallbacks? _notificationsCallbacks;

  NewNotificationCubit({
    required NavigationHandler navigationHandler,
    required SnackBarHandler snackBarHandler,
    required SaveNotificationUseCase saveNotificationUseCase,
    NotificationsCallbacks? notificationsCallbacks,
  })  : _saveNotificationUseCase = saveNotificationUseCase,
        _navigationHandler = navigationHandler,
        _snackBarHandler = snackBarHandler,
        _notificationsCallbacks = notificationsCallbacks,
        super(const NewNotificationState.initial());

  void onTitleChanged(String value) {
    emit(state.copyWith(title: FieldValue(value: value)));
  }

  void onDescriptionChanged(String value) {
    emit(state.copyWith(description: FieldValue(value: value)));
  }

  void onDateChanged(DateTime value) {
    emit(state.copyWith(date: FieldValue(value: value)));
  }

  void onTimeChanged(Time value) {
    emit(state.copyWith(time: FieldValue(value: value)));
  }

  bool _validateFields() {
    final titleError = ValidationUtils.validateTitle(state.title.value);
    final dateError = ValidationUtils.validateDate(
      state.date.value?.add(
        Duration(
            hours: state.time.value?.hour ?? 0,
            minutes: state.time.value?.minute ?? 0),
      ),
    );
    final timeError = ValidationUtils.validateTime(state.time.value);

    emit(
      state.copyWith(
        title: state.title.copyWithError(titleError),
        date: state.date.copyWithError(dateError),
        time: state.time.copyWithError(timeError),
      ),
    );

    return [titleError, dateError, timeError].every((error) => error == null);
  }

  void onCreateNotificationClicked() async {
    // if (!_validateFields()) return;

    final fullDate = state.date.value!.add(
      state.time.value!.toDuration(),
    );

    final request = SaveNotificationRequest(
      title: state.title.value,
      description: state.description.value,
      date: fullDate,
      isActive: true,
      isRepeating: false,
    );

    final newNotification = await _saveNotificationUseCase(request);

    _navigationHandler.popScreen();

    _snackBarHandler.showSnackBar('Notification created');

    _notificationsCallbacks?.onNotificationAdded(newNotification);
  }
}
