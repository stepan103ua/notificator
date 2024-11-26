part of 'alert_cubit.dart';

class AlertState extends Equatable {
  final Notification? notification;
  const AlertState(this.notification);

  @override
  List<Object?> get props => [notification];
}
