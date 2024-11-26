import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notificator/domain/entities/notification.dart';
import 'package:notificator/domain/usecases/get_notification_by_id_use_case.dart';

part 'alert_state.dart';

class AlertCubit extends Cubit<AlertState> {
  final GetNotificationByIdUseCase _getNotificationByIdUseCase;

  AlertCubit({
    required int id,
    required GetNotificationByIdUseCase getNotificationByIdUseCase,
  })  : _getNotificationByIdUseCase = getNotificationByIdUseCase,
        super(const AlertState(null)) {
    _init(id);
  }

  void _init(int id) async {
    final notification = await _getNotificationByIdUseCase(id);

    emit(AlertState(notification));
  }
}
