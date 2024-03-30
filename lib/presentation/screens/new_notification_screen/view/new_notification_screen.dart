import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notificator/core/ui_events_handler/ui_events_handler_cubit.dart';
import 'package:notificator/presentation/screens/new_notification_screen/cubit/new_notification__cubit.dart';
import 'package:notificator/presentation/screens/notifications_screen/cubit/notifications_cubit.dart';
import 'package:notificator/presentation/widgets/date_picker_field.dart';
import 'package:notificator/presentation/widgets/time_picker_field.dart';

class NewNotificationScreen extends StatelessWidget {
  static const routeName = '/new-notification';

  const NewNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationsCubit? notificationsCubit =
        GoRouterState.of(context).extra as NotificationsCubit?;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: notificationsCubit!),
        BlocProvider(
          create: (context) => NewNotificationCubit(
            navigationHandler: context.read<UiEventsHandlerCubit>(),
            snackBarHandler: context.read<UiEventsHandlerCubit>(),
            notificationsCallbacks: context.read<NotificationsCubit>(),
            saveNotificationUseCase: context.read(),
          ),
        ),
      ],
      child: BlocBuilder<NewNotificationCubit, NewNotificationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('New notification'),
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    errorText: state.title.error,
                  ),
                  onChanged:
                      context.read<NewNotificationCubit>().onTitleChanged,
                ),
                const SizedBox(height: 16),
                DatePickerField(
                  textInputAction: TextInputAction.next,
                  onDateChanged:
                      context.read<NewNotificationCubit>().onDateChanged,
                  errorText: state.date.error,
                ),
                const SizedBox(height: 16),
                TimePickerField(
                  textInputAction: TextInputAction.next,
                  onTimeChanged:
                      context.read<NewNotificationCubit>().onTimeChanged,
                  errorText: state.time.error,
                ),
                const SizedBox(height: 16),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    errorText: state.description.error,
                    alignLabelWithHint: true,
                    enabledBorder: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(),
                    errorBorder: const OutlineInputBorder(),
                  ),
                  onChanged:
                      context.read<NewNotificationCubit>().onDescriptionChanged,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: context
                      .read<NewNotificationCubit>()
                      .onCreateNotificationClicked,
                  child: const Text('Create'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
