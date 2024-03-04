import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notificator/core/mixins/with_side_effects.dart';
import 'package:notificator/core/ui_events_handler/callbacks/navigation_handler.dart';
import 'package:notificator/domain/entities/notification.dart';
import 'package:notificator/domain/entities/side_effect.dart';
import 'package:notificator/domain/usecases/get_notifications_use_case.dart';
import 'package:notificator/domain/usecases/update_notification_use_case.dart';
import 'package:notificator/presentation/screens/new_notification_screen/view/new_notification_screen.dart';

import 'notifications_callbacks.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState>
    implements NotificationsCallbacks {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final UpdateNotificationUseCase _updateNotificationUseCase;
  final NavigationHandler _openScreenCallback;

  NotificationsCubit({
    required GetNotificationsUseCase getNotificationsUseCase,
    required UpdateNotificationUseCase updateNotificationUseCase,
    required NavigationHandler openScreenCallback,
  })  : _getNotificationsUseCase = getNotificationsUseCase,
        _updateNotificationUseCase = updateNotificationUseCase,
        _openScreenCallback = openScreenCallback,
        super(const NotificationsLoading()) {
    _onInit();
  }

  Future<void> _onInit() async {
    try {
      final notifications = await _getNotificationsUseCase();
      emit(state.loaded(notifications.toList()));
    } catch (e) {
      emit(state.error(e.toString()));
    }
  }

  void onNotificationActivityChanged(int index) {
    final notification = state.notifications.elementAt(index);

    final updatedNotification =
        notification.copyWith(isActive: !notification.isActive);

    final updatedNotifications = state.notifications
        .map((e) => e == notification ? updatedNotification : e)
        .toList();

    emit(state.loaded(updatedNotifications));

    _updateNotificationUseCase(
      Notification(
        id: updatedNotification.id,
        title: updatedNotification.title,
        description: updatedNotification.description,
        isActive: updatedNotification.isActive,
        isRepeating: updatedNotification.isRepeating,
        date: updatedNotification.date,
      ),
    );
  }

  void onCreateNotificationClicked() {
    _openScreenCallback.pushScreen(NewNotificationScreen.routeName, this);
  }

  @override
  void onNotificationAdded(Notification notification) {
    emit(state.loaded([...state.notifications, notification]));
  }
}
