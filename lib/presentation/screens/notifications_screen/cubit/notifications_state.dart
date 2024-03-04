part of 'notifications_cubit.dart';

sealed class NotificationsState extends Equatable with WithSideEffects {
  final List<Notification> notifications;
  @override
  final Iterable<SideEffect> sideEffects;

  const NotificationsState({
    required this.sideEffects,
    required this.notifications,
  });

  NotificationsLoaded loaded(List<Notification> notifications) =>
      NotificationsLoaded(
        sideEffects: sideEffects,
        notifications: notifications,
      );

  NotificationsError error(String message) => NotificationsError(
        message: message,
        sideEffects: sideEffects,
        notifications: notifications,
      );

  @override
  NotificationsState onSideEffectsUpdated(Iterable<SideEffect> sideEffects) =>
      NotificationsLoaded(
        sideEffects: sideEffects,
        notifications: notifications,
      );

  @override
  List<Object> get props => [sideEffects];
}

class NotificationsLoaded extends NotificationsState {
  const NotificationsLoaded({
    super.sideEffects = const [],
    required super.notifications,
  });

  @override
  List<Object> get props => [notifications];
}

class NotificationsLoading extends NotificationsState {
  const NotificationsLoading({
    super.sideEffects = const [],
    super.notifications = const [],
  });
}

class NotificationsError extends NotificationsState {
  final String message;

  const NotificationsError({
    required this.message,
    super.sideEffects = const [],
    super.notifications = const [],
  });

  @override
  List<Object> get props => [message];
}
